{ user, ... }: {
  # Basic
  inherit user;

  # Programs
  terminal = "wezterm";
  fileManager = "thunar";
  browser = "firefox";
  editor = "nvim";
  shell = "fish";

  # Rofi Based
  launcher = "bash -c \"pkill rofi || true; rofi -show drun -theme launcher.rasi\"";
  powermenu = "bash -c \"pkill rofi || true; bash /home/${user}/.config/rofi/powermenu/powermenu.sh\"";
  close_launcher = "pkill rofi";
  close_powermenu = "pkill rofi";

  # Scripts
  change_wallpaper = "bash /nixos-config/users/${user}/bin/change_wallpaper.sh";

  # UI settings
  cursorSize = 16;

  # Keys
  key = {
    mainMod = "Super";
    controlMod = "Ctrl";
    altMod = "Alt";
    shiftMod = "Shift";
  };
}
