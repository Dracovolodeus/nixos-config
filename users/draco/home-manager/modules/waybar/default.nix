{ var, ... }: {
  programs.waybar = {
    enable = true;
    style = ./style.css;
    settings = {
      "mainBar" = {
        layer = "top";
        position = "top";
        height = 35;
        modules-left = [
          "custom/launcher"
          "niri/workspaces"
          "custom/powermenu"
        ];
        modules-center = [
          "niri/language"
          "clock"
          "pulseaudio"
          "pulseaudio#microphone"
          "cava"
        ];
        modules-right = [
          "battery"
          "cpu"
          "disk"
          "memory"
        ];
        "niri/workspaces" = {
          active-only = false;
          disable-scroll = true;
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
            sort-by-number = true;
          };
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
            "6" = [ ];
            "7" = [ ];
            "8" = [ ];
            "9" = [ ];
            "10" = [ ];
          };
        };
        "niri/language" = {
          format = "{shortDescription}";
          on-click = "";
          min-length = 5;
          tooltip = false;
        };
        "pulseaudio" = {
          format = " {icon} {volume}% ";
          format-muted = "  muted ";
          format-icons = {
            headphone = "";
            default = [ " " " " " " ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click-right = "pavucontrol";
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = " {volume}% ";
          format-source-muted = " muted ";
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          on-click-right = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.01+ -l 1.0";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 0.01-";
        };
        "cava" = {
          hide_on_silence = false;
          framerate = 60;
          bars = 10;
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
          input_delay = 1;
          sleep_timer = 5;
          bar_delimiter = 0;
        };
        "clock" = {
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format = "{:%H:%M:%S}";
          interval = 5;
          calendar = {
            mode = "month";
            on-scroll = 1;
            format = {
              months = "<span color='#b4befe'><b>{}</b></span>";
              days = "<span color='#b4befe'><b>{}</b></span>";
              weeks = "<span color='#b4befe'><b>{}</b></span>";
              weekdays = "<span color='#b4befe'><b>{}</b></span>";
              today = "<span color='#74c7ec'><b>{}</b></span>";
            };
          };
          actions = {
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
            on-click = "shift_reset";
          };
        };
        "cpu" = {
          interval = 3;
          format = "   {usage}% ";
        };
        "disk" = {
          format = " 󰋊 {percentage_used}% ";
          interval = 3600;
        };
        "memory" = {
          interval = 3;
          format = "   {used}GB/{total}GB ";
        };
        "battery" = {
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          format = " {icon} {capacity}% ";
          full-at = 100;
          interval = 90;
          states = {
            warning = 25;
            critical = 5;
          };
        };
        "custom/launcher" = {
          format = " 󱄅 ";
          tooltip-format = "Launching a rofi-based launcher";
          on-click = "${var.program.launcher.open}";
          on-click-right = "${var.program.launcher.close}";
        };
        "custom/powermenu" = {
          format = " 󰐥 ";
          tooltip-format = "Launching powermenu based on rofi";
          on-click = "${var.program.powermenu.open}";
          on-click-right = "${var.program.powermenu.close}";
        };
      };
    };
  };
}

