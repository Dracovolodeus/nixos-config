{ pkgs, ... }: {
  home = {
    packages = with pkgs; [ fastfetch ];
    file.".config/fastfetch/config.jsonc".text = /* json */ ''
    {
      "logo": {
        "padding": {
          "top": 0
        }
      },
      "display": {
        "separator": " >>> ",
        "constants": [
          "─────────────────────────"
        ]
      },
      "modules": [
        {
          "type": "custom",
          "format": "{$1}{$1}",
          "outputColor": "90"
        },
        {
          "type": "title",
          "key": "User",
          "keyWidth": 10
        },
        {
          "type": "custom",
          "format": "{#90} {#31} {#32} {#33} {#34} {#35} {#36} {#37} {#38} {#39} "
        },

        // OS
        {
          "type": "os",
          "key": " OS",
          "keyColor": "yellow"
        },
        {
          "type": "kernel",
          "key": "│ ├",
          "keyColor": "yellow"
        },
        {
          "type": "packages",
          "key": "│ ├󰏖",
          "keyColor": "yellow"
        },
        {
          "type": "shell",
          "key": "│ └",
          "keyColor": "yellow"
        },

        // WM
        {
          "type": "wm",
          "key": " WM",
          "keyColor": "blue"
        },
        {
          "type": "lm",
          "key": "│ ├󰧨",
          "keyColor": "blue"
        },
        {
          "type": "wmtheme",
          "key": "│ ├󰉼",
          "keyColor": "blue"
        },
        {
          "type": "icons",
          "key": "│ ├󰀻",
          "keyColor": "blue"
        },
        {
          "type": "terminal",
          "key": "│ ├",
          "keyColor": "blue"
        },
        {
          "type": "wallpaper",
          "key": "│ └󰸉",
          "keyColor": "blue"
        },

        // PC
        {
          "type": "host",
          "key": "󰌢 PC",
          "keyColor": "green"
        },
        {
          "type": "display",
          "key": "│ └󰍹",
          "keyColor": "green"
        },
        {
          "type": "cpu",
          "key": "│ ├󰻠",
          "keyColor": "green"
        },
        {
          "type": "gpu",
          "key": "│ ├󰍛",
          "keyColor": "green"
        },
        {
          "type": "disk",
          "key": "│ ├",
          "keyColor": "green"
        },
        {
          "type": "memory",
          "key": "│ ├󰑭",
          "keyColor": "green"
        },
        {
          "type": "swap",
          "key": "│ ├󰓡",
          "keyColor": "green"
        },
        {
          "type": "uptime",
          "key": "│ ├󰅐",
          "keyColor": "green"
        },

        {
          "type": "custom",
          "format": "{$1}{$1}",
          "outputColor": "90"
        },
      ]
    }
    '';
  };
}
