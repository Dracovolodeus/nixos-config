{ pkgs, var, ... }: {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {

      # Swaylock-effects specific
      clock = true;
      effect-blur = "15x3";

      # Swaylock specific
      daemonize = true;
      ignore-empty-password = true;
      indicator-caps-lock = true;
      show-keyboard-layout = true;
      indicator-idle-visible = true;
      indicator-radius = 125;
      indicator-thickness = 25;
      fade-in = 1;

      # Background
      image = "${var.path.lockscreenImage}";
      color = "#1e1e2e";

      # Ring segments
      bs-hl-color = "#313244";
      caps-lock-key-hl-color = "#313244";
      key-hl-color = "#313244";
      caps-lock-bs-hl-color = "#313244";

      # Inside color
      inside-color = "#1e1e2e";
      inside-caps-lock-color = "#1e1e2e";
      inside-clear-color = "#1e1e2e";
      inside-ver-color = "#1e1e2e";
      inside-wrong-color = "#1e1e2e";

      # Layout background color
      layout-bg-color = "#11111b";
      layout-border-color = "#181825";
      layout-text-color = "#cdd6f4";

      # Line
      line-color = "#1e1e2e";
      line-caps-lock-color = "#1e1e2e";
      line-clear-color = "#1e1e2e";
      line-ver-color = "#1e1e2e";
      line-wrong-color = "#1e1e2e";

      # Ring
      ring-color = "#b4befe";
      ring-caps-lock-color = "#cba6f7";
      ring-clear-color = "#f9e2af";
      ring-ver-color = "#a6e3a1";
      ring-wrong-color = "#f38ba8";

      # Text
      text-color = "#cdd6f4";
      text-caps-lock-color = "#cba6f7";
      text-clear-color = "#f9e2af";
      text-ver-color = "#a6e3a1";
      text-wrong-color = "#f38ba8";

      # Separator
      separator-color = "#00000000";
    };
  };
}
