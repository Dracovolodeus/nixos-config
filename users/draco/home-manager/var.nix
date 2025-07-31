{ user, ... }: {

  # Basic
  inherit user;
  terminal = "wezterm";
  editor = "nvim";
  shell = "fish";
  fileManager = "thunar";
  browser = "firefox";
  cursorSize = 16;

  # Rofi Based
  launcher = "bash -c \"pkill rofi || true; rofi -show drun -theme launcher.rasi\"";
  powermenu = "bash -c \"pkill rofi || true; bash $HOME/.config/rofi/powermenu/powermenu.sh\"";

  # HotKeys
  hotkey = {
    mainMod = "super";
    controlMod = "ctrl";
    altMod = "alt";
  };

}
