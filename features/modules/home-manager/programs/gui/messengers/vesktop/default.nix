{ config, ... }:
let
  colors = config.internal.theme.colors;
in
{
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "stable";
      transparencyOption = "none";
      customTitleBar = false;
      staticTitle = true;
      disableMinSize = true;
      enableMenu = false;

      tray = true;
      minimizeToTray = true;
      clickTrayToShowHide = true;
      appBadge = false;
      enableTaskbarFlashing = true;

      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      disableSmoothScroll = false;
      openLinksWithElectron = false;
      arRPC = false;

      enableSplashScreen = true;
      splashTheming = true;
      splashColor = colors.base17;
      splashBackground = colors.base00;
      splashPixelated = false;

      spellCheckLanguages = [
        "ru"
        "en-US"
      ];

      audio = {
        workaround = false;
        deviceSelect = true;
        granularSelect = true;
        ignoreVirtual = false;
        ignoreDevices = false;
        ignoreInputMedia = false;
        onlySpeakers = false;
        onlyDefaultSpeakers = false;
      };

      firstLaunch = false;
      linuxAutoStartEnabled = false;
    };

    vencord.settings = {
      autoUpdate = false;
      autoUpdateNotification = false;

      useQuickCss = true;

      frameless = false;
      transparent = false;
      disableMinSize = true;

      enableReactDevtools = false;
      eagerPatches = false;

      notifications = {
        timeout = 5000;
        position = "top-right";
        useNative = "not-focused";
        logLimit = 25;
      };

      cloud.settingsSync = false;

      plugins = {
        FakeNitro = {
          enabled = true;
        };
        MessageLogger = {
          enabled = true;
          ignoreSelf = true;
        };
        Translate = {
          enabled = true;
          autoTranslate = false;
        };
      };
    };
  };
}
