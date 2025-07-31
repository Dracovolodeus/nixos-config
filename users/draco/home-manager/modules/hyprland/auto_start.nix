{ var, ... }: {
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "waybar"
      "swww init"
      "hyprctl setcursor Bibata-Modern-Ice ${toString var.cursorSize}"
      "bash /nixos-config/bin/change_wallpaper.sh"
    ];
  };
}
