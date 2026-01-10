{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.variables = ["--all"];
    settings = {
      monitor = ",preferred,auto,1";
    };
  };
}
