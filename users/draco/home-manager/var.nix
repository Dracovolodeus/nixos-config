{ user, ... }: {
  inherit user; # User

  program = { # Programs
    terminal.name = "wezterm";
    terminal.open = "wezterm";

    fileManager.name = "thunar";
    fileManager.open = "thunar";

    browser.name = "firefox";
    browser.open = "firefox";

    statusLine.open = "waybar";
    statusLine.close = "pkill waybar";
    statusLine.toggle = "pkill waybar || waybar";

    editor.name = "nvim";
    shell.name = "fish";

    launcher.open = "bash -c 'pkill rofi || true; rofi -show drun -theme launcher.rasi'";
    launcher.close = "pkill rofi";
    powermenu.open = "bash -c 'pkill rofi || true; bash /home/${user}/.config/rofi/powermenu/powermenu.sh'";
    powermenu.close = "pkill rofi";
  };

  scripts = { # Scripts
    changeWallpaper = "bash /nixos-config/users/${user}/scripts/change_wallpaper.sh";
  };

  ui = { # UI settings
    cursor = {
      size = 16;
    };

    key = { # Keys
      mainMod = "Super";
      controlMod = "Ctrl";
      alternateMod = "Alt";
      shiftMod = "Shift";
    };
  };

  path = { # Settings
    screenshot = "/home/${user}/Multimedia/images/screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
    lockscreenImage = "/nixos-config/users/${user}/assets/lockscreen/image";
  };
}
