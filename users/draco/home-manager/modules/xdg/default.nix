{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    config.common.default = ["gnome"];
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
  };
}
