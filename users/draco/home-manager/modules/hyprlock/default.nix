let
  textColor = "rgb(180, 190, 254)";
  backgroundColor = "rgb(49, 50, 68)";
  borderColor = "rgb (180, 190, 254)";
  errorColor = "rgb(235, 160, 172)";
  font = "JetBrainsMono Nerd Font";
in
{
  programs.hyprlock = {
    enable = true;
    settings =
      {

        # GENERAL
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        # INPUT FIELD
        input-field = [
          {
            monitor = "";
            size = "300, 60";
            outline_thickness = 4;
            dots_size = 0.2;
            dots_spacing = 0.2;
            dots_center = true;
            outer_color = "${borderColor}";
            inner_color = "${backgroundColor}";
            font_color = "${textColor}";
            fade_on_empty = false;
            hide_input = false;
            check_color = "${borderColor}";
            fail_color = "${errorColor}";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            capslock_color = "${borderColor}";
            position = "0, -47";
            halign = "center";
            valign = "center";
          }
        ];

        # BACKGROUND
        background = [
          {
            monitor = "";
            path = "screenshot";
            blur_passes = 3;
            noise = 0.0117;
            contrast = 0.9;
            brightness = 0.75;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          }
        ];

        # LAYOUT
        label = [
          {
            monitor = "";
            text = "Layout: $LAYOUT";
            color = "${textColor}";
            font_size = 25;
            font_family = "${font}";
            position = "-30, 10";
            halign = "right";
            valign = "bottom";
          }

          # TIME
          {
            monitor = "";
            text = "$TIME";
            color = "${textColor}";
            font_size = 90;
            font_family = "${font}";
            position = "-30, 0";
            halign = "right";
            valign = "top";
          }

          # DATE
          {
            monitor = "";
            text = "cmd[update:43200000] date +\"%A, %d %B %Y\"";
            color = "${textColor}";
            font_size = 25;
            font_family = "${font}";
            position = "-30, -150";
            halign = "right";
            valign = "top";
          }
        ];
      };
  };
}
