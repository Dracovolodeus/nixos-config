{
  programs.vesktop.enable = true;
  programs.vesktop.vencord.settings = {
    autoUpdate = false;
    autoUpdateNotification = false;
    disableMinSize = true;
    notifyAboutUpdates = false;
    plugins = {
      FakeNitro = {
        enabled = true;
      };
    };
  };
}
