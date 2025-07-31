{ var, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",preferred,auto,1";

      "$terminal" = var.terminal;
      "$fileManager" = var.fileManager;
      "$browser" = var.browser;
      "$shell" = var.shell;
      "$editor" = var.editor;
      "$launcher" = var.launcher;
      "$powermenu" = var.powermenu;

      "$mainMod" = var.hotkey.mainMod;
      "$controlMod" = var.hotkey.controlMod;
      "$altMod" = var.hotkey.altMod;
    };
  };
}

