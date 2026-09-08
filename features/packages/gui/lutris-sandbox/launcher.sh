# shellcheck shell=bash

readonly program_name="lutris-sandbox"

umask 077

die() {
  printf '%s: %s\n' "$program_name" "$*" >&2
  exit 2
}

usage() {
  cat <<'EOF'
Usage:
  lutris-sandbox [Lutris command and arguments...]
  lutris-sandbox status <game-root-or-prefix>
  lutris-sandbox reset <game-root-or-prefix>

The launch form is intended for Lutris's Command prefix setting.
EOF
}

is_within() {
  local child="$1"
  local parent="$2"

  [[ "$child" == "$parent" || "$child" == "$parent/"* ]]
}

canonical_dir() {
  local path="$1"
  local label="$2"

  [[ -d "$path" ]] || die "$label is not an existing directory: $path"
  realpath -e -- "$path"
}

require_socket_name() {
  local name="$1"
  local label="$2"

  [[ -n "$name" && "$name" != */* && "$name" != *$'\n'* ]] || die "$label must be a socket name"
}

initialize_paths() {
  [[ -n "${LUTRIS_SANDBOX_LIBRARY_ROOT:-}" ]] || die "LUTRIS_SANDBOX_LIBRARY_ROOT is not configured"
  [[ -n "${LUTRIS_SANDBOX_STATE_ROOT:-}" ]] || die "LUTRIS_SANDBOX_STATE_ROOT is not configured"

  library_root="$(canonical_dir "$LUTRIS_SANDBOX_LIBRARY_ROOT" "library root")"

  [[ "$LUTRIS_SANDBOX_STATE_ROOT" == /* ]] || die "state root must be an absolute path"
  [[ ! -L "$LUTRIS_SANDBOX_STATE_ROOT" ]] || die "state root must not be a symlink"
  mkdir -p -- "$LUTRIS_SANDBOX_STATE_ROOT"
  state_root="$(canonical_dir "$LUTRIS_SANDBOX_STATE_ROOT" "state root")"
  [[ "$(stat -c %u -- "$state_root")" == "$(id -u)" ]] || die "state root must be owned by the current user"
  chmod 700 "$state_root"

  if is_within "$state_root" "$library_root"; then
    die "state root must not be inside the game library"
  fi
}

resolve_game_root() {
  local requested_path="$1"
  local resolved_path relative_path child_name

  resolved_path="$(canonical_dir "$requested_path" "Wine prefix")"
  is_within "$resolved_path" "$library_root" || die "Wine prefix is outside the configured game library: $resolved_path"
  [[ "$resolved_path" != "$library_root" ]] || die "Wine prefix must be inside a game directory"

  relative_path="${resolved_path#"$library_root"/}"
  child_name="${relative_path%%/*}"
  game_root="$(canonical_dir "$library_root/$child_name" "game root")"

  is_within "$game_root" "$library_root" || die "game root resolves outside the configured game library"
  [[ "$game_root" != "$library_root" ]] || die "game root must be a direct child of the game library"
  is_within "$resolved_path" "$game_root" || die "Wine prefix is not inside its direct-child game root"

  wine_prefix="$resolved_path"
}

prepare_game_state() {
  local recorded_root

  game_hash="$(printf '%s' "$game_root" | sha256sum | cut -d ' ' -f 1)"
  game_state="$state_root/$game_hash"
  game_identity="$game_state/identity"
  game_upper="$game_state/game.upper"
  game_work="$game_state/game.work"
  game_home="$game_state/home"
  game_lock="$game_state/lock"
  game_quarantine="$game_state/quarantined"

  [[ ! -L "$game_state" ]] || die "game state must not be a symlink"
  mkdir -p -- "$game_state" "$game_quarantine"
  chmod 700 "$game_state" "$game_quarantine"

  [[ ! -L "$game_identity" ]] || die "game identity must not be a symlink"
  if [[ -e "$game_identity" ]]; then
    IFS= read -r recorded_root < "$game_identity" || true
    [[ "$recorded_root" == "$game_root" ]] || die "sandbox state belongs to a different game root"
  else
    (umask 077 && printf '%s\n' "$game_root" > "$game_identity")
  fi

  for state_dir in "$game_upper" "$game_work" "$game_home"; do
    [[ ! -L "$state_dir" ]] || die "sandbox state directory must not be a symlink: $state_dir"
    mkdir -p -- "$state_dir"
    chmod 700 "$state_dir"
  done
}

acquire_game_lock() {
  exec 9>"$game_lock"
  flock -n 9 || die "game is already running: $game_root"
}

add_read_only_dir_if_present() {
  local source="$1"

  [[ -d "$source" ]] || return 0
  sandbox_args+=(--ro-bind "$source" "$source")
}

copy_environment_if_set() {
  local name="$1"

  [[ -v "$name" ]] || return 0
  sandbox_args+=(--setenv "$name" "${!name}")
}

copy_runtime_environment() {
  local name

  for name in \
    PATH \
    LANG \
    LANGUAGE \
    LC_ALL \
    LC_CTYPE \
    LC_MESSAGES \
    LC_NUMERIC \
    LC_TIME \
    LOGNAME \
    USER \
    TZ \
    XDG_CURRENT_DESKTOP \
    XDG_SESSION_DESKTOP \
    XDG_SESSION_TYPE \
    DESKTOP_SESSION \
    XDG_DATA_DIRS \
    XDG_CONFIG_DIRS \
    LD_LIBRARY_PATH \
    LD_PRELOAD \
    DRI_PRIME \
    PULSE_LATENCY_MSEC \
    STORE \
    GAMEID \
    LUTRIS_GAME_UUID; do
    copy_environment_if_set "$name"
  done

  for name in \
    "${!DXVK_@}" \
    "${!GBM_@}" \
    "${!LIBGL_@}" \
    "${!MESA_@}" \
    "${!PROTON_@}" \
    "${!UMU_@}" \
    "${!VK_@}" \
    "${!WINE@}" \
    "${!__GL_@}"; do
    case "$name" in
      WINEPREFIX|PROTONPATH|UMU_RUNTIME_UPDATE) ;;
      *) copy_environment_if_set "$name" ;;
    esac
  done
}

add_device_if_present() {
  local source="$1"

  [[ -e "$source" ]] || return 0
  sandbox_args+=(--dev-bind "$source" "$source")
}

add_audio_sockets() {
  local pipewire_socket pulse_socket

  pipewire_socket="${PIPEWIRE_REMOTE:-pipewire-0}"
  require_socket_name "$pipewire_socket" "PIPEWIRE_REMOTE"

  if [[ -S "$host_runtime_dir/$pipewire_socket" ]]; then
    sandbox_args+=(
      --bind "$host_runtime_dir/$pipewire_socket" "$sandbox_runtime_dir/$pipewire_socket"
      --setenv PIPEWIRE_REMOTE "$pipewire_socket"
    )
  fi

  pulse_socket="$host_runtime_dir/pulse/native"
  if [[ -S "$pulse_socket" ]]; then
    sandbox_args+=(
      --bind "$pulse_socket" "$sandbox_runtime_dir/pulse/native"
      --setenv PULSE_SERVER "unix:$sandbox_runtime_dir/pulse/native"
    )
  else
    sandbox_args+=(--unsetenv PULSE_SERVER)
  fi
}

add_display_socket() {
  local display_number x_socket xauthority

  if [[ "${PROTON_ENABLE_WAYLAND:-0}" == "1" ]]; then
    require_socket_name "${WAYLAND_DISPLAY:-}" "WAYLAND_DISPLAY"
    [[ -S "$host_runtime_dir/$WAYLAND_DISPLAY" ]] || die "Wayland socket is unavailable: $host_runtime_dir/$WAYLAND_DISPLAY"

    sandbox_args+=(
      --bind "$host_runtime_dir/$WAYLAND_DISPLAY" "$sandbox_runtime_dir/$WAYLAND_DISPLAY"
      --setenv WAYLAND_DISPLAY "$WAYLAND_DISPLAY"
      --unsetenv DISPLAY
      --unsetenv XAUTHORITY
    )
    return
  fi

  [[ "${DISPLAY:-}" =~ ^:([0-9]+)(\.[0-9]+)?$ ]] || die "an Xwayland DISPLAY such as :0 is required"
  display_number="${BASH_REMATCH[1]}"
  x_socket="/tmp/.X11-unix/X$display_number"
  [[ -S "$x_socket" ]] || die "Xwayland socket is unavailable: $x_socket"

  sandbox_args+=(
    --dir /tmp/.X11-unix
    --bind "$x_socket" "$x_socket"
    --setenv DISPLAY "$DISPLAY"
    --unsetenv WAYLAND_DISPLAY
  )

  if [[ -n "${XAUTHORITY:-}" && -f "$XAUTHORITY" ]]; then
    xauthority="$(realpath -e -- "$XAUTHORITY")"
    if ! is_within "$xauthority" "$host_runtime_dir" && [[ "$xauthority" != "$host_home/.Xauthority" ]]; then
      die "XAUTHORITY must be below XDG_RUNTIME_DIR or equal to $host_home/.Xauthority"
    fi
    sandbox_args+=(--ro-bind "$xauthority" "$xauthority" --setenv XAUTHORITY "$xauthority")
  else
    sandbox_args+=(--unsetenv XAUTHORITY)
  fi
}

validate_proton_path() {
  local runners_root steam_tools_root

  [[ -n "${PROTONPATH:-}" && "$PROTONPATH" == /* ]] || die "select a concrete GE-Proton version; PROTONPATH must be absolute"
  proton_path="$(canonical_dir "$PROTONPATH" "PROTONPATH")"

  runners_root="$host_home/.local/share/lutris/runners"
  steam_tools_root="$host_home/.local/share/Steam/compatibilitytools.d"

  if [[ -d "$runners_root" ]]; then
    runners_root="$(canonical_dir "$runners_root" "Lutris runner directory")"
  fi
  if [[ -d "$steam_tools_root" ]]; then
    steam_tools_root="$(canonical_dir "$steam_tools_root" "Steam compatibility-tools directory")"
  fi

  if ! { [[ -d "$runners_root" ]] && is_within "$proton_path" "$runners_root"; } && ! { [[ -d "$steam_tools_root" ]] && is_within "$proton_path" "$steam_tools_root"; }; then
    die "PROTONPATH must be below Lutris runners or Steam compatibilitytools.d"
  fi

  [[ -f "$proton_path/proton" ]] || die "PROTONPATH is not a Proton tool directory: $proton_path"
}

run_sandbox() {
  local current_dir

  [[ $# -gt 0 ]] || die "Lutris supplied no command"
  [[ -n "${WINEPREFIX:-}" ]] || die "WINEPREFIX is required"
  [[ -n "${HOME:-}" && "$HOME" == /* ]] || die "HOME must be an absolute path"
  [[ -n "${XDG_RUNTIME_DIR:-}" ]] || die "XDG_RUNTIME_DIR is required"

  initialize_paths
  host_home="$(canonical_dir "$HOME" "HOME")"
  host_runtime_dir="$(canonical_dir "$XDG_RUNTIME_DIR" "XDG_RUNTIME_DIR")"
  resolve_game_root "$WINEPREFIX"
  prepare_game_state
  acquire_game_lock
  validate_proton_path

  umu_data="$host_home/.local/share/umu"
  [[ -d "$umu_data" ]] || die "UMU data is missing: $umu_data"
  umu_data="$(canonical_dir "$umu_data" "UMU data")"

  uid="$(id -u)"
  sandbox_runtime_dir="/run/user/$uid"
  current_dir="$(realpath -e -- . 2>/dev/null || true)"
  if ! is_within "$current_dir" "$game_root"; then
    current_dir="$game_root"
  fi

  sandbox_args=(
    --die-with-parent
    --new-session
    --unshare-ipc
    --unshare-pid
    --unshare-uts
    --sync-fd 9

    --ro-bind /usr /usr
    --symlink /usr/bin /bin
    --symlink /usr/sbin /sbin
    --symlink /usr/lib /lib
    --symlink /usr/lib32 /lib32
    --symlink /usr/lib64 /lib64
    --symlink /usr/libexec /libexec
    --ro-bind /nix /nix
    --ro-bind /etc /etc
    --ro-bind-try /.host-etc /.host-etc
    --ro-bind /sys /sys

    --proc /proc
    --dev /dev
    --perms 01777 --tmpfs /dev/shm
    --perms 01777 --tmpfs /tmp
    --perms 01777 --tmpfs /var/tmp
    --tmpfs /run
    --dir /run/user
    --perms 0700 --dir "$sandbox_runtime_dir"

    --bind "$game_home" "$host_home"
    --overlay-src "$game_root"
    --overlay "$game_upper" "$game_work" "$game_root"
    --overlay-src "$proton_path"
    --tmp-overlay "$proton_path"
    --overlay-src "$umu_data"
    --tmp-overlay "$host_home/.local/share/umu"

    --setenv HOME "$host_home"
    --setenv WINEPREFIX "$wine_prefix"
    --setenv XDG_CONFIG_HOME "$host_home/.config"
    --setenv XDG_DATA_HOME "$host_home/.local/share"
    --setenv XDG_CACHE_HOME "$host_home/.cache"
    --setenv XDG_STATE_HOME "$host_home/.local/state"
    --setenv XDG_RUNTIME_DIR "$sandbox_runtime_dir"
    --setenv UMU_RUNTIME_UPDATE 0
    --clearenv
    --unsetenv DBUS_SESSION_BUS_ADDRESS
    --unsetenv SSH_AUTH_SOCK
    --unsetenv GPG_AGENT_INFO
    --unsetenv NIRI_SOCKET
    --unsetenv LUTRIS_SANDBOX_LIBRARY_ROOT
    --unsetenv LUTRIS_SANDBOX_STATE_ROOT
    --unsetenv LUTRIS_SANDBOX_NETWORK
    --chdir "$current_dir"
  )

  copy_runtime_environment

  sandbox_args+=(
    --setenv HOME "$host_home"
    --setenv WINEPREFIX "$wine_prefix"
    --setenv PROTONPATH "$proton_path"
    --setenv XDG_CONFIG_HOME "$host_home/.config"
    --setenv XDG_DATA_HOME "$host_home/.local/share"
    --setenv XDG_CACHE_HOME "$host_home/.cache"
    --setenv XDG_STATE_HOME "$host_home/.local/state"
    --setenv XDG_RUNTIME_DIR "$sandbox_runtime_dir"
    --setenv UMU_RUNTIME_UPDATE 0
  )

  case "${LUTRIS_SANDBOX_NETWORK:-0}" in
    ""|0) sandbox_args+=(--unshare-net) ;;
    1) ;;
    *) die "LUTRIS_SANDBOX_NETWORK must be 0 or 1" ;;
  esac

  add_read_only_dir_if_present /run/current-system/sw
  add_read_only_dir_if_present /run/opengl-driver
  add_read_only_dir_if_present /run/opengl-driver-32
  add_read_only_dir_if_present /run/udev/data

  for device in \
    /dev/dri \
    /dev/nvidiactl \
    /dev/nvidia-modeset \
    /dev/nvidia-uvm \
    /dev/nvidia-uvm-tools \
    /dev/nvidia-caps \
    /dev/nvidia[0-9]* \
    /dev/ntsync; do
    add_device_if_present "$device"
  done

  add_display_socket
  add_audio_sockets

  exec bwrap "${sandbox_args[@]}" -- "$@"
}

status_game() {
  local requested_path="$1"

  initialize_paths
  resolve_game_root "$requested_path"
  game_hash="$(printf '%s' "$game_root" | sha256sum | cut -d ' ' -f 1)"
  game_state="$state_root/$game_hash"

  printf 'game root: %s\n' "$game_root"
  printf 'state: %s\n' "$game_state"
  if [[ -d "$game_state" ]]; then
    printf 'state exists: yes\n'
  else
    printf 'state exists: no\n'
  fi
}

reset_game() {
  local requested_path="$1"
  local quarantine

  initialize_paths
  resolve_game_root "$requested_path"
  prepare_game_state
  acquire_game_lock

  quarantine="$(mktemp -d -- "$game_quarantine/reset-XXXXXXXX")"

  for state_dir in "$game_upper" "$game_work" "$game_home"; do
    [[ -e "$state_dir" ]] && mv -- "$state_dir" "$quarantine/$(basename "$state_dir")"
    mkdir -p -- "$state_dir"
    chmod 700 "$state_dir"
  done

  printf 'sandbox state reset; previous state: %s\n' "$quarantine"
}

main() {
  case "${1:-}" in
    --help|-h|help)
      usage
      ;;
    status)
      [[ $# -eq 2 ]] || die "usage: lutris-sandbox status <game-root-or-prefix>"
      status_game "$2"
      ;;
    reset)
      [[ $# -eq 2 ]] || die "usage: lutris-sandbox reset <game-root-or-prefix>"
      reset_game "$2"
      ;;
    *)
      run_sandbox "$@"
      ;;
  esac
}

main "$@"
