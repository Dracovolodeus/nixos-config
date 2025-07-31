{
  wayland.windowManager.hyprland.settings = {
    animations = {
      enabled = true;
      bezier = [
        "almostLinear, 0.5, 0.5, 0.75, 1.0"
        "shape, 1, 0.71, 0.06, 0.96"
        "linear, 1, 1, 0, 0"
        "decel, 0.1, 1, 0, 1"
      ];
      animation = [
        "global, 1, 10, default"
        "border, 1, 7.5, linear"
        "windows, 1, 5, shape"
        "windowsIn, 1, 3, shape"
        "windowsOut, 1, 5, linear"
        "fade, 1, 3.03, shape"
        "fadeIn, 1, 1.73, almostLinear"
        "fadeOut, 1, 1.46, almostLinear"
        "fadeLayersIn, 1, 0.1, linear"
        "fadeLayersOut, 1, 0.1, linear"
        "layers, 1, 2.25, shape, slide"
        "layersIn, 1, 2.25, shape, popin 25%"
        "layersOut, 1, 1.5, shape, popin 25%"
        "workspaces, 1, 7, decel, slide"
      ];
    };
  };
}
