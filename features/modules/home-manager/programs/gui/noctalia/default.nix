{
  config,
  pkgs,
  lib,
  user,
  ...
}:
let
  colors = config.internal.theme.colors;
  noctaliaExe = lib.getExe pkgs.noctalia;
  busctlExe = lib.getExe' pkgs.systemd "busctl";
in
{
  home.packages = [ pkgs.noctalia ];

  xdg.configFile."noctalia/config.toml".text = /* toml */ ''
    [audio]
    enable_overdrive = true

    [bar.default]
    capsule_radius = 6
    capsule_thickness = 0.99999998137354851
    center = [ "workspaces" ]
    concave_edge_corners = false
    end = [ "battery", "launcher", "network", "bluetooth", "group:g1", "tray" ]
    margin_ends = 0
    panel_overlap = 3
    position = "left"
    radius = 0
    shadow = false
    start = [ "keyboard_layout", "clock", "output_volume", "audio_visualizer", "input_volume", "brightness" ]
    thickness = 40
    widget_spacing = 10

        [[bar.default.capsule_group]]
        accordion = false
        accordion_direction = "end"
        enabled = true
        fill = "surface_variant"
        id = "g1"
        members = [ "cpu", "temp", "ram" ]
        opacity = 1.0
        padding = 6.0

    [battery]
    warning_threshold = 15

        [battery.device."/org/freedesktop/UPower/devices/headset_dev_F8_BA_98_15_C1_46"]
        warning_threshold = 20

    [control_center]
    hidden_tabs = [ "weather", "notifications", "screen-time" ]
    sidebar_section = "none"

    [desktop_widgets]
    schema_version = 2
    widget_order = [
        "desktop-widget-0000000000000001",
        "desktop-widget-0000000000000009",
        "desktop-widget-000000000000000b",
        "desktop-widget-000000000000000c"
    ]

        [desktop_widgets.grid]
        cell_size = 64
        major_interval = 4
        visible = true

        [desktop_widgets.widget.desktop-widget-0000000000000001]
        box_height = 512.0
        box_width = 512.0
        cx = 1664.0
        cy = 605.58251953125
        output = "eDP-1"
        placement_height = 1080.0
        placement_width = 1920.0
        rotation = 0.0
        type = "fancy_audio_visualizer"

            [desktop_widgets.widget.desktop-widget-0000000000000001.settings]
            background = false
            bar_width = 0.69999999999999996
            rotation_speed = 0.70000000000000007
            visualization_mode = "bars_rings"

        [desktop_widgets.widget.desktop-widget-0000000000000009]
        box_height = 192.0
        box_width = 1856.0
        cx = 991.0859375
        cy = 983.0859375
        output = "eDP-1"
        placement_height = 1080.0
        placement_width = 1920.0
        rotation = 0.0
        type = "audio_visualizer"

            [desktop_widgets.widget.desktop-widget-0000000000000009.settings]
            background = false
            bands = 24
            centered = false
            mirrored = true
            reversed = false
            show_when_idle = false

        [desktop_widgets.widget.desktop-widget-000000000000000b]
        box_height = 259.1650390625
        box_width = 361.0390625
        cx = 1738.56640625
        cy = 220.0
        output = "eDP-1"
        placement_height = 1080.0
        placement_width = 1920.0
        rotation = 0.0
        type = "sysmon"

            [desktop_widgets.widget.desktop-widget-000000000000000b.settings]
            stat = "cpu_usage"
            stat2 = "cpu_temp"

        [desktop_widgets.widget.desktop-widget-000000000000000c]
        box_height = 250.73046875
        box_width = 606.84375
        cx = 468.6015625
        cy = 205.705078125
        output = "eDP-1"
        placement_height = 1080.0
        placement_width = 1920.0
        rotation = 0.0
        type = "clock"

            [desktop_widgets.widget.desktop-widget-000000000000000c.settings]
            background_padding = 5
            background_radius = 6
            center_text = true
            clock_style = "digital"
            shadow = false

    [hooks]
    battery_charging = "${noctaliaExe} msg desktop-widgets-show"
    battery_discharging = "${noctaliaExe} msg desktop-widgets-hide"
    battery_plugged = "${noctaliaExe} msg desktop-widgets-show"
    started = '${noctaliaExe} msg color-scheme-set custom CurrentTheme; state="$(${busctlExe} --system get-property org.freedesktop.UPower /org/freedesktop/UPower org.freedesktop.UPower OnBattery 2>/dev/null)" || exit 0; case "$state" in "b true") ${noctaliaExe} msg desktop-widgets-hide ;; "b false") ${noctaliaExe} msg desktop-widgets-show ;; esac'

    [idle]
    behavior_order = [ "screen-off", "lock", "suspend" ]
    pre_action_fade_seconds = 2.0

        [idle.behavior.screen-off]
        action = "screen_off"
        enabled = true
        timeout = 630

        [idle.behavior.lock]
        action = "lock"
        enabled = true
        timeout = 1200

        [idle.behavior.suspend]
        action = "lock_and_suspend"
        enabled = true
        timeout = 2700

    [lockscreen_widgets]
    enabled = false
    schema_version = 2
    widget_order = [ "lockscreen-login-box@eDP-1" ]

        [lockscreen_widgets.grid]
        cell_size = 16
        major_interval = 4
        visible = true

        [lockscreen_widgets.widget."lockscreen-login-box@eDP-1"]
        box_height = 196.0
        box_width = 810.0
        cx = 960.0
        cy = 898.0
        output = "eDP-1"
        placement_height = 1080.0
        placement_width = 1920.0
        rotation = 0.0
        type = "login_box"

            [lockscreen_widgets.widget."lockscreen-login-box@eDP-1".settings]
            background_color = "surface_variant"
            background_opacity = 0.88
            background_radius = 12.0
            center_password_text = false
            input_opacity = 1.0
            input_radius = 6.0
            layout = "regular"
            show_caps_lock = true
            show_keyboard_layout = true
            show_login_button = true
            show_media = true
            show_session_buttons = true
            show_unlock_hint = true
            show_weather = true

    [notification]
    background_opacity = 0.89999997988343239
    layer = "overlay"
    offset_x = 10
    offset_y = 5
    scale = 1.1000000089406967
    show_actions = false

    [osd]
    background_opacity = 0.89999997988343239
    offset_x = 0
    offset_y = 5
    scale = 1.2000000104308128

        [osd.kinds]
        media = false

    [shell]
    button_borders = false
    card_borders = false
    input_borders = false

        [shell.animation]
        enabled = false

        [shell.panel]
        control_center_position = "center"
        open_near_click_control_center = true
        session_placement = "floating"
        session_position = "center"

        [[shell.session.actions]]
        action = "lock"
        countdown_seconds = 0.0
        enabled = true
        shortcut = "1"
        variant = "default"

        [[shell.session.actions]]
        action = "lock_and_suspend"
        countdown_seconds = 0.0
        enabled = true
        shortcut = "3"
        variant = "default"

        [[shell.session.actions]]
        action = "logout"
        countdown_seconds = 0.0
        enabled = false
        shortcut = "2"
        variant = "default"

        [[shell.session.actions]]
        action = "reboot"
        countdown_seconds = 0.0
        enabled = true
        shortcut = "4"
        variant = "default"

        [[shell.session.actions]]
        action = "shutdown"
        countdown_seconds = 0.0
        enabled = true
        shortcut = "5"
        variant = "destructive"

        [shell.shadow]
        alpha = 0.0

    [theme]
    builtin = "Catppuccin"
    custom_palette = "CurrentTheme"
    mode = "dark"
    source = "custom"
    wallpaper_scheme = "m3-content"

    [wallpaper]
    directory = "/nixos-config/features/users/${user}/wallpapers"
    edge_smoothness = 0.05
    enabled = true
    fill_color = "#000000"
    fill_mode = "crop"
    transition = [ "stripes" ]
    transition_duration = 1500
    transition_on_startup = true

        [wallpaper.automation]
        enabled = true
        interval_seconds = 1500
        order = "random"
        recursive = true

    [weather]
    enabled = false

    [widget.audio_visualizer]
    show_when_idle = true

    [widget.bluetooth.actions]
    right = "none"

    [widget.clock]
    format = "{:%H:%M:%S}"

    [widget.cpu]
    stat = "gpu_usage"
    visualization = "none"

    [widget.launcher]
    glyph = "rocket"

    [widget.network.actions]
    right = "none"

    [widget.ram]
    stat = "ram_pct"
    visualization = "none"

    [widget.temp]
    visualization = "none"

    [widget.tray]
    drawer = true
    hide_passive = false

    [widget.workspaces]
    labels_only_when_occupied = true
    scale = 1.4000000000000001
    scroll_repeat = "steps"

        [widget.workspaces.actions]
        right = "panel-toggle control-center home"
        scroll_down = "none"
        scroll_up = "none"
  '';

  xdg.configFile."noctalia/palettes/CurrentTheme.json".text = builtins.toJSON {
    dark = {
      mError = colors.base08;
      mHover = colors.base0E;
      mOnError = colors.base11;
      mOnHover = colors.base11;
      mOnPrimary = colors.base11;
      mOnSecondary = colors.base11;
      mOnSurface = colors.base05;
      mOnSurfaceVariant = colors.base17;
      mOnTertiary = colors.base11;
      mOutline = colors.base04;
      mPrimary = colors.base17;
      mSecondary = colors.base12;
      mShadow = colors.base11;
      mSurface = colors.base00;
      mSurfaceVariant = colors.base01;
      mTertiary = colors.base0E;
      terminal = {
        background = colors.base00;
        bright = {
          black = colors.base03;
          blue = colors.base0D;
          cyan = colors.base0C;
          green = colors.base0B;
          magenta = colors.base0E;
          red = colors.base08;
          white = colors.base07;
          yellow = colors.base0A;
        };
        cursor = colors.base05;
        cursorText = colors.base00;
        foreground = colors.base05;
        normal = {
          black = colors.base00;
          blue = colors.base0D;
          cyan = colors.base0C;
          green = colors.base0B;
          magenta = colors.base0E;
          red = colors.base08;
          white = colors.base05;
          yellow = colors.base0A;
        };
        selectionBg = colors.base03;
        selectionFg = colors.base05;
      };
    };
    light = {
      mError = colors.base08;
      mHover = colors.base08;
      mOnError = colors.base06;
      mOnHover = colors.base05;
      mOnPrimary = colors.base05;
      mOnSecondary = colors.base05;
      mOnSurface = colors.base00;
      mOnSurfaceVariant = colors.base02;
      mOnTertiary = colors.base05;
      mOutline = colors.base06;
      mPrimary = colors.base0D;
      mSecondary = colors.base12;
      mShadow = colors.base06;
      mSurface = colors.base05;
      mSurfaceVariant = colors.base07;
      mTertiary = colors.base0E;
      terminal = {
        background = colors.base05;
        bright = {
          black = colors.base03;
          blue = colors.base0D;
          cyan = colors.base0C;
          green = colors.base0B;
          magenta = colors.base0E;
          red = colors.base08;
          white = colors.base07;
          yellow = colors.base0A;
        };
        cursor = colors.base00;
        cursorText = colors.base05;
        foreground = colors.base00;
        normal = {
          black = colors.base00;
          blue = colors.base0D;
          cyan = colors.base0C;
          green = colors.base0B;
          magenta = colors.base0E;
          red = colors.base08;
          white = colors.base05;
          yellow = colors.base0A;
        };
        selectionBg = colors.base02;
        selectionFg = colors.base05;
      };
    };
  };
}
