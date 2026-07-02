{ config, ... }:
let
  gtkConf = config.internal.theme.gtk;
in
{
  gtk = {
    enable = true;
    gtk4.theme = null;

    iconTheme = gtkConf.iconTheme;
    theme = gtkConf.theme;
    cursorTheme = gtkConf.cursorTheme;

    gtk3.extraConfig.gtk-application-prefer-dark-theme = gtkConf.prefer-dark-theme;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = gtkConf.prefer-dark-theme;
  };
}
