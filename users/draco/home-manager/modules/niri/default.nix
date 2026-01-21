{ var, ... }: 
let
  mainMod = var.ui.key.mainMod;
  altMod = var.ui.key.alternateMod;
  shiftMod = var.ui.key.shiftMod;
  ctrlMod = var.ui.key.controlMod;
in {
  home.file.".config/niri/config.kdl".text /*kdl*/ = ''
  prefer-no-csd

  spawn-at-startup "${var.program.statusLine.open}"
  spawn-sh-at-startup "swww-daemon"

  screenshot-path "${var.path.screenshot}"

  output "eDP-1" {
    mode "1920x1080@144.003"
    focus-at-startup
    hot-corners {
      top-right
    }
    scale 1
    transform "normal"
  }

  input {
    keyboard {
      repeat-rate 40
      repeat-delay 300
      xkb {
        layout "us,ru"
        options "grp:alt_shift_toggle"
      }
      numlock
    }

    touchpad {
      tap
      tap-button-map "left-right-middle"
    }

    disable-power-key-handling
    focus-follows-mouse
  }

  layout {
    gaps 0
    center-focused-column "never"
    default-column-width { proportion 0.5; }

    preset-column-widths {
      proportion 0.25
      proportion 0.5
      proportion 0.75
    }

    focus-ring {
      off
    }

    border {
      on
      width 1
      active-gradient from="#b4befe" to="#cba6f7" angle=45
      inactive-color "#45475a"
    }

    struts {
      left 0
      right 0
      top 0
      bottom 0
    }
  }

  animations {
    window-open {
      duration-ms 125
      curve "linear"
    }
    window-close {
      duration-ms 125
      curve "linear"
    }
    workspace-switch {
      duration-ms 250
      curve "cubic-bezier" 0.1 1 0 1
    }
    window-movement {
      duration-ms 125
      curve "cubic-bezier" 1 0.71 0.06 0.96
    }
    window-resize {
      duration-ms 125
      curve "linear"
    }
    exit-confirmation-open-close {
      duration-ms 1000
      curve "cubic-bezier" 0.1 1 0 1
    }
    screenshot-ui-open {
      duration-ms 225
      curve "linear"
    }
    overview-open-close {
      duration-ms 150
      curve "cubic-bezier" 0.5 0.5 0.75 1.0
    }
    recent-windows-close {
      duration-ms 150
      curve "cubic-bezier" 0.5 0.5 0.75 1.0
    }
  }

  binds {
    ${mainMod}+${shiftMod}+Slash { show-hotkey-overlay; }

    ${mainMod}+O repeat=false { toggle-overview; }

    // Run applications
    ${mainMod}+return repeat=false hotkey-overlay-title="Open a Terminal: ${var.program.terminal.name}" { spawn "${var.program.terminal.open}"; }
    ${mainMod}+R repeat=false hotkey-overlay-title="Run an Application Launcher" { spawn-sh "${var.program.launcher.open}"; }
    ${mainMod}+P repeat=false hotkey-overlay-title="Run an Powermenu" {spawn-sh "${var.program.powermenu.open}"; }
    ${mainMod}+${shiftMod}+T repeat=false hotkey-overlay-title="Open a File manager: ${var.program.fileManager.name}" {spawn "${var.program.fileManager.open}"; }
    ${mainMod}+${shiftMod}+F repeat=false hotkey-overlay-title="Open a Brouser: ${var.program.browser.name}" { spawn "${var.program.browser.open}"; }

    ${mainMod}+Q repeat=false { close-window; }

    // Move applications
    ${mainMod}+${shiftMod}+E { toggle-window-floating; }
    ${mainMod}+E { switch-focus-between-floating-and-tiling; }

    ${mainMod}+H { focus-column-left; }
    ${mainMod}+J { focus-window-or-workspace-down; }
    ${mainMod}+K { focus-window-or-workspace-up; }
    ${mainMod}+L { focus-column-right; }

    ${mainMod}+${shiftMod}+H { move-column-left; }
    ${mainMod}+${shiftMod}+L { move-column-right; }
    ${mainMod}+${shiftMod}+J { move-window-down-or-to-workspace-down; }
    ${mainMod}+${shiftMod}+K { move-window-up-or-to-workspace-up; }
    ${mainMod}+${ctrlMod}+J { move-window-to-workspace-down; }
    ${mainMod}+${ctrlMod}+K { move-window-to-workspace-up; }

    ${mainMod}+${ctrlMod}+R { switch-preset-column-width-back; }
    ${mainMod}+F { maximize-column; }
    ${mainMod}+M { fullscreen-window; }

    ${mainMod}+${ctrlMod}+F { expand-column-to-available-width; }

    ${mainMod}+Minus { set-column-width "-10%"; }
    ${mainMod}+Equal { set-column-width "+10%"; }
    ${mainMod}+${shiftMod}+Minus { set-window-height "-10%"; }
    ${mainMod}+${shiftMod}+Equal { set-window-height "+10%"; }

    // Screenshot
    Print { screenshot; }
    ${ctrlMod}+Print { screenshot-screen; }
    ${altMod}+Print { screenshot-window; }

    ${mainMod}+${altMod}+Q { quit; }
    ${mainMod}+${altMod}+W repeat=false hotkey-overlay-title="Change wallpapaer" { spawn-sh "${var.scripts.changeWallpaper}"; }
    ${mainMod}+${altMod}+B repeat=false hotkey-overlay-title="Toggle bar" { spawn-sh "${var.program.statusLine.toggle}"; }

    ${mainMod}+${shiftMod}+U { move-workspace-down; }
    ${mainMod}+${shiftMod}+I { move-workspace-up; }

    ${mainMod}+1 { focus-workspace 1; }
    ${mainMod}+2 { focus-workspace 2; }
    ${mainMod}+3 { focus-workspace 3; }
    ${mainMod}+4 { focus-workspace 4; }
    ${mainMod}+5 { focus-workspace 5; }
    ${mainMod}+6 { focus-workspace 6; }
    ${mainMod}+7 { focus-workspace 7; }
    ${mainMod}+8 { focus-workspace 8; }
    ${mainMod}+9 { focus-workspace 9; }
    ${mainMod}+0 { focus-workspace 10; }

    ${mainMod}+${shiftMod}+1 { move-column-to-workspace 1; }
    ${mainMod}+${shiftMod}+2 { move-column-to-workspace 2; }
    ${mainMod}+${shiftMod}+3 { move-column-to-workspace 3; }
    ${mainMod}+${shiftMod}+4 { move-column-to-workspace 4; }
    ${mainMod}+${shiftMod}+5 { move-column-to-workspace 5; }
    ${mainMod}+${shiftMod}+6 { move-column-to-workspace 6; }
    ${mainMod}+${shiftMod}+7 { move-column-to-workspace 7; }
    ${mainMod}+${shiftMod}+8 { move-column-to-workspace 8; }
    ${mainMod}+${shiftMod}+9 { move-column-to-workspace 9; }
    ${mainMod}+${shiftMod}+0 { move-column-to-workspace 0; }


    XF86AudioRaiseVolume allow-when-locked=true repeat=false { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0"; }
    XF86AudioLowerVolume allow-when-locked=true repeat=false { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"; }
    XF86AudioMute        allow-when-locked=true repeat=false { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
    XF86AudioMicMute     allow-when-locked=true repeat=false { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

    XF86AudioPlay        allow-when-locked=true repeat=false { spawn-sh "playerctl play-pause"; }
    XF86AudioStop        allow-when-locked=true repeat=false { spawn-sh "playerctl stop"; }
    XF86AudioPrev        allow-when-locked=true repeat=false { spawn-sh "playerctl previous"; }
    XF86AudioNext        allow-when-locked=true repeat=false { spawn-sh "playerctl next"; }

    XF86MonBrightnessUp allow-when-locked=true repeat=false { spawn "brightnessctl" "--class=backlight" "set" "+5%"; }
    XF86MonBrightnessDown allow-when-locked=true repeat=false { spawn "brightnessctl" "--class=backlight" "set" "5%-"; }
  }

  hotkey-overlay {
    skip-at-startup
  }

  xwayland-satellite {
    path "xwayland-satellite"
  }

  cursor {
    xcursor-theme "Bibata-Modern-Ice"
    xcursor-size 16
    hide-when-typing
    hide-after-inactive-ms 5000
  }

  environment {
    QT_QPA_PLATFORM "wayland"
    XDG_CURRENT_DESKTOP "GNOME"
    NIXOS_OZONE_WL "1"
    GDK_BACKEND "wayland";
    SDL_VIDEODRIVER "wayland";
    CLUTTER_BACKEND "wayland";
    XDG_SESSION_TYPE "wayland";
    QT_AUTO_SCREEN_SCALE_FACTOR "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION "1";
  }

  overview {
    backdrop-color "#181825"
    zoom 0.50
    workspace-shadow {
      off
    }
  }

  clipboard {
    disable-primary
  }

  recent-windows { off; }

  window-rule {
    open-maximized true
    clip-to-geometry true
  }

  window-rule {
    match app-id=r#"firefox$"# title="^Picture-in-Picture$"
    open-floating true
  }

  window-rule {
    match app-id="wezterm"
    exclude is-active=true
    open-maximized false
  }

  window-rule {
    match app-id="thunar"
    exclude is-active=true
    open-maximized false
  }

  window-rule {
    match app-id="imv"
    open-floating true
  }

  window-rule {
    match app-id="mpv"
    open-floating true
  }

  window-rule {
    match app-id="org.pulseaudio.pavucontrol"
    open-floating true
    default-column-width {fixed 650; }
    default-window-height { fixed 500; }
    default-floating-position x=0 y=0 relative-to="top"
    match is-focused=true
  }
  '';
}
