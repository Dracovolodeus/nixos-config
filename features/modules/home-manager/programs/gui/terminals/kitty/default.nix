{
  config,
  lib,
  pkgs,
  ...
}:
let
  kittyExe = lib.getExe pkgs.kitty;
  colors = config.internal.theme.colors;
in
{
  home = {
    packages = with pkgs; [ nerd-fonts.jetbrains-mono ];
    sessionVariables = {
      TERMINAL = kittyExe;
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono NFM";
      size = 14;
      package = pkgs.nerd-fonts.jetbrains-mono;
    };

    settings = {
      confirm_os_window_close = 0;

      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 2;

      window_border_width = "1pt";
      draw_minimal_borders = true;

      window_padding_width = "0 3 0 3";
      placement_strategy = "top-left";

      # cursor_shape = "beam";
      # cursor_trail = 25;
      # cursor_trail_decay = "0.1 0.25";

      foreground = colors.base05;
      background = colors.base00;
      cursor = colors.base13;
      cursor_text_color = colors.base00;
      selection_background = colors.base13;
      selection_foreground = colors.base00;
      active_tab_foreground = colors.base0E;
      active_tab_background = colors.base01;
      inactive_tab_foreground = colors.base05;
      inactive_tab_background = colors.base02;
      tab_bar_margin_color = colors.base00;
      active_border_color = colors.base0E;
      inactive_border_color = colors.base02;
      bell_border_color = colors.base08;

      color0 = colors.base02;
      color1 = colors.base08;
      color2 = colors.base0E;
      color3 = colors.base0A;
      color4 = colors.base0D;
      color5 = colors.base12;
      color6 = colors.base0C;
      color7 = colors.base07;
      color8 = colors.base03;
      color9 = colors.base08;
      color10 = colors.base0E;
      color11 = colors.base0A;
      color12 = colors.base0D;
      color13 = colors.base12;
      color14 = colors.base0C;
      color15 = colors.base06;
      color16 = colors.base09;
      color17 = colors.base13;
    };

    keybindings = {
      "ctrl+shift+t" = "launch --type=tab --cwd=current";
      "ctrl+alt+1" = "goto_tab 1";
      "ctrl+alt+2" = "goto_tab 2";
      "ctrl+alt+3" = "goto_tab 3";
      "ctrl+alt+4" = "goto_tab 4";
      "ctrl+alt+5" = "goto_tab 5";
      "ctrl+alt+6" = "goto_tab 6";
      "ctrl+alt+7" = "goto_tab 7";
      "ctrl+alt+8" = "goto_tab 8";
      "ctrl+alt+9" = "goto_tab 9";
      "ctrl+alt+0" = "goto_tab 10";
      "ctrl+alt+k" = "next_tab";
      "ctrl+alt+j" = "prev_tab";

      "ctrl+shift+enter" = "launch --cwd=current";
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+j" = "neighboring_window down";
      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+l" = "neighboring_window right";

      "ctrl+shift+q" = "no_op";
    };
  };
}
