local wezterm = require("wezterm")
local config = {}

config = {
  hide_tab_bar_if_only_one_tab = true,
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font({
      family = "JetBrainsMono NFM",
      weight = "Medium",
    }),

  scrollback_lines = 5000,
  enable_wayland = false,
  check_for_updates = false,

  window_close_confirmation = "NeverPrompt",


  cursor_blink_rate = 800,
  default_cursor_style = "BlinkingBar",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",

  window_frame = {
    font = wezterm.font({
      family = "JetBrainsMono NFM",
      weight = "Bold",
    }),
    font_size = 10.0,
    active_titlebar_bg = "#181825",
    inactive_titlebar_bg = "#181825",
  },

  window_padding = {
    left = 2,
    right = 2,
    top = 0,
    bottom = 0,
  },

  colors = {
    tab_bar = {
      inactive_tab_edge = "#1e1e2e",
      background = "transparent",
      active_tab = {
        bg_color = "#1e1e2e",
        fg_color = "#c6a0f6",
        intensity = "Normal",
        underline = "None",
        italic = false,
        strikethrough = false,
      },
    }
  },

  color_schemes = {
    ["Catppuccin Mocha"] = {
      foreground = "#cdd6f4",
      background = "#1e1e2e",
      cursor_bg = "#f5e0dc",
      cursor_fg = "#1e1e2e",
      selection_bg = "#f5e0dc",
      selection_fg = "#1e1e2e",
      ansi = {
        "#45475a",
        "#f38ba8",
        "#cba6f7",
        "#f9e2af",
        "#89b4fa",
        "#f5c2e7",
        "#94e2d5",
        "#bac2de",
      },
      brights = {
        "#585b70",
        "#f38ba8",
        "#cba6f7",
        "#f9e2af",
        "#89b4fa",
        "#f5c2e7",
        "#94e2d5",
        "#a6adc8",
      },
      indexed = {
        [16] = "#fab387",
        [17] = "#f5e0dc",
      },
    },
  },
}

return config

