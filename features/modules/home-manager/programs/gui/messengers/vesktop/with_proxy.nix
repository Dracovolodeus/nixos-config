{
  imports = [ ./default.nix ];
  xdg.desktopEntries.vesktop = {
    name = "Vesktop";
    exec = "vesktop --proxy-server=\"http://127.0.0.1:2080\" %U";
    icon = "vesktop";
    categories = [
      "Network"
      "InstantMessaging"
    ];
    mimeType = [ "x-scheme-handler/discord" ];
  };
}
