{
  config,
  pkgs,
  lib,
  ...
}:
let
  theme = config.internal.theme;
  noctaliaExe = lib.getExe pkgs.noctalia-shell;
  kittyExe = lib.getExe pkgs.kitty;
  wpctlExe = lib.getExe' pkgs.wireplumber "wpctl";
  thunarExe = lib.getExe pkgs.thunar;
  firefoxExe = lib.getExe pkgs.firefox;
  playerctlExe = lib.getExe pkgs.playerctl;
  brightnessctlExe = lib.getExe pkgs.brightnessctl;
  xwaylandSatelliteExe = lib.getExe pkgs.xwayland-satellite;
in
{
  imports = [ ./_configure_protals.nix ];

  home.packages = with pkgs; [
    niri
    xdg-utils
    wl-clipboard
  ];

  home.file.".config/niri/config.kdl".text # kdl
    =
      ''
        prefer-no-csd

        spawn-at-startup "${noctaliaExe}"
        screenshot-path "${config.home.homeDirectory}/Multimedia/images/screenshots/scr-%Y-%m-%dT%H-%M-%S.png"

        gestures {
          hot-corners {
            top-right
          }
        }

        input {
          mod-key "Super";
          mod-key-nested "Alt";
          keyboard {
            repeat-rate 45
            repeat-delay 275
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
            active-gradient from="${theme.colors.base17}" to="${theme.colors.base0E}" angle=45
            inactive-color "${theme.colors.base02}"
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
          Mod+Shift+Slash { show-hotkey-overlay; }

          Mod+O repeat=false { toggle-overview; }

          // Run applications
          Mod+Return repeat=false hotkey-overlay-title="Open Terminal." { spawn "${kittyExe}" "--single-instance"; }
          Mod+Shift+T repeat=false hotkey-overlay-title="Open File Manager." {spawn "${thunarExe}"; }
          Mod+Shift+F repeat=false hotkey-overlay-title="Open Brouser." { spawn "${firefoxExe}"; }

          // Noctalia
          Mod+R repeat=false hotkey-overlay-title="Open Application Launcher." { spawn "${noctaliaExe}" "ipc" "call" "launcher" "toggle"; }
          Mod+P repeat=false hotkey-overlay-title="Open Session Menu." { spawn "${noctaliaExe}" "ipc" "call" "sessionMenu" "toggle"; }
          Mod+Alt+B repeat=false hotkey-overlay-title="Toggle Bar." { spawn "${noctaliaExe}" "ipc" "call" "bar" "toggle"; }
          Mod+Ctrl+W repeat=false hotkey-overlay-title="Toggle Wallpaper." { spawn "${noctaliaExe}" "ipc" "call" "wallpaper" "toggle"; }
          Mod+Alt+W repeat=false hotkey-overlay-title="Set Random Wallpaper." { spawn "${noctaliaExe}" "ipc" "call" "wallpaper" "random"; }

          Mod+Q repeat=false { close-window; }

          // Move applications
          Mod+Shift+E { toggle-window-floating; }
          Mod+E { switch-focus-between-floating-and-tiling; }

          Mod+H { focus-column-left; }
          Mod+J { focus-window-or-workspace-down; }
          Mod+K { focus-window-or-workspace-up; }
          Mod+L { focus-column-right; }

          Mod+Shift+H { move-column-left; }
          Mod+Shift+L { move-column-right; }
          Mod+Shift+J { move-window-down-or-to-workspace-down; }
          Mod+Shift+K { move-window-up-or-to-workspace-up; }
          Mod+Ctrl+J { move-window-to-workspace-down; }
          Mod+Ctrl+K { move-window-to-workspace-up; }

          Mod+Ctrl+R { switch-preset-column-width-back; }
          Mod+F { maximize-column; }
          Mod+M { fullscreen-window; }

          Mod+Ctrl+F { expand-column-to-available-width; }

          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          // Screenshot
          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          Mod+Alt+Q { quit; }

          Mod+Shift+U { move-workspace-down; }
          Mod+Shift+I { move-workspace-up; }

          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }
          Mod+0 { focus-workspace 10; }

          Mod+Shift+1 { move-column-to-workspace 1; }
          Mod+Shift+2 { move-column-to-workspace 2; }
          Mod+Shift+3 { move-column-to-workspace 3; }
          Mod+Shift+4 { move-column-to-workspace 4; }
          Mod+Shift+5 { move-column-to-workspace 5; }
          Mod+Shift+6 { move-column-to-workspace 6; }
          Mod+Shift+7 { move-column-to-workspace 7; }
          Mod+Shift+8 { move-column-to-workspace 8; }
          Mod+Shift+9 { move-column-to-workspace 9; }
          Mod+Shift+0 { move-column-to-workspace 0; }

          XF86AudioRaiseVolume allow-when-locked=true repeat=false { spawn "${wpctlExe}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+" "-l" "1.0"; }
          XF86AudioLowerVolume allow-when-locked=true repeat=false { spawn "${wpctlExe}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
          XF86AudioMute allow-when-locked=true repeat=false { spawn "${wpctlExe}" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioMicMute allow-when-locked=true repeat=false { spawn "${wpctlExe}" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

          XF86AudioPlay allow-when-locked=true repeat=false { spawn "${playerctlExe}" "play-pause"; }
          XF86AudioStop allow-when-locked=true repeat=false { spawn "${playerctlExe}" "stop"; }
          XF86AudioPrev allow-when-locked=true repeat=false { spawn "${playerctlExe}" "previous"; }
          XF86AudioNext allow-when-locked=true repeat=false { spawn "${playerctlExe}" "next"; }

          XF86MonBrightnessUp allow-when-locked=true repeat=false { spawn "${brightnessctlExe}" "--class=backlight" "set" "+5%"; }
          XF86MonBrightnessDown allow-when-locked=true repeat=false { spawn "${brightnessctlExe}" "--class=backlight" "set" "5%-"; }
        }

        hotkey-overlay {
          skip-at-startup
        }

        xwayland-satellite {
          path "${xwaylandSatelliteExe}"
        }

        cursor {
          xcursor-theme "${theme.gtk.cursorTheme.name}"
          xcursor-size ${toString theme.gtk.cursorTheme.size}
          hide-when-typing
          hide-after-inactive-ms 5000
        }

        environment {
          NIXOS_OZONE_WL "1"
          GDK_BACKEND "wayland"
          QT_QPA_PLATFORM "wayland"
          SDL_VIDEODRIVER "wayland"
          CLUTTER_BACKEND "wayland"
          XDG_SESSION_TYPE "wayland"
          XDG_CURRENT_DESKTOP "GNOME"
          QT_AUTO_SCREEN_SCALE_FACTOR "1"
          QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
        }

        overview {
          backdrop-color "${theme.colors.base10}"
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
          match app-id="kitty"
          exclude is-active=true
          open-maximized false
        }

        window-rule {
          match app-id=".blueman-manager-wrapped"
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
