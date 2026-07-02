{ pkgs, ... }: {
  colors = {
    base00 = "#1e1e2e"; # Base
    base01 = "#313244"; # Surface0
    base02 = "#45475a"; # Surface1
    base03 = "#585b70"; # Surface2
    base04 = "#6c7086"; # Overlay0
    base05 = "#cdd6f4"; # Text
    base06 = "#a6adc8"; # Subtext0
    base07 = "#bac2de"; # Subtext1
    base08 = "#f38ba8"; # Red
    base09 = "#fab387"; # Peach
    base0A = "#f9e2af"; # Yellow
    base0B = "#a6e3a1"; # Green
    base0C = "#94e2d5"; # Teal
    base0D = "#89b4fa"; # Blue
    base0E = "#cba6f7"; # Mauve
    base0F = "#eba0ac"; # Maroon
    base10 = "#181825"; # Mantle
    base11 = "#11111b"; # Crust
    base12 = "#f5c2e7"; # Pink
    base13 = "#f5e0dc"; # Rosewater
    base14 = "#f2cdcd"; # Flamingo
    base15 = "#89dceb"; # Sky
    base16 = "#74c7ec"; # Sapphire
    base17 = "#b4befe"; # Lavender
  };

  gtk = {
    prefer-dark-theme = true;
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
      name = "Papirus-Dark";
    };
    theme = {
      name = "catppuccin-mocha-lavender-compact";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        variant = "mocha";
        size = "compact";
      };
    };
    cursorTheme = {
      size = 16;
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };
  qt = {
    style.name = "kvantum";
    platformTheme.name = "kvantum";
    packages = with pkgs; [
      bibata-cursors
      qt6Packages.qtstyleplugin-kvantum
      libsForQt5.qtstyleplugin-kvantum
      (catppuccin-kvantum.override {
        accent = "lavender";
        variant = "mocha";
      })
    ];
    xdg.configFile.text = ''
      [General]
      theme=catppuccin-mocha-lavender
    '';
    envs = {
      QT_QPA_PLATFORMTHEME = "kvantum";
      QT_STYLE_OVERRIDE = "kvantum";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "16";
    };
  };
}
