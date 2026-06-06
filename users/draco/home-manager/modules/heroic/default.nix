{ config, pkgs, lib, ... }:

let
  json = pkgs.formats.json { };
  
  heroicConfigStructure = {
    userHome = config.home.homeDirectory;
    defaultSettings = {
      enviromentOptions = [ ];
      wrapperOptions = [ ];

      analyticsOptIn = false;
      checkUpdatesInterval = 0;
      enableUpdates = false;
      hideChangelogsOnStartup = true;

      addDesktopShortcuts = false;
      addStartMenuShortcuts = false;
      libraryTopSection = "recently_played";

      autoInstallDxvk = true;
      autoInstallVkd3d = true;
      autoInstallDxvkNvapi = true;

      addSteamShortcuts = false;
      preferSystemLibs = true;
      checkForUpdatesOnStartup = true;
      autoUpdateGames = false;

      defaultInstallPath = "${config.home.homeDirectory}/Games/Heroic";
      defaultSteamPath = "${config.home.homeDirectory}/.steam/steam";
      defaultWinePrefix = "${config.home.homeDirectory}/Games/Heroic/Prefixes";

      language = "en";
      maxWorkers = 0;
      minimizeOnLaunch = false;
      nvidiaPrime = false;
      showFps = false;
      useGameMode = false;

      customWinePaths = [ ];

      wineCrossoverBottle = "Heroic";
      winePrefix = "${config.home.homeDirectory}/Games/Heroic/Prefixes";

      battlEyeRuntime = true;
      disableUMU = false;
      eacRuntime = true;
      enableEsync = true;
      enableFsync = true;
      enableHDR = false;
      enableMsync = false;
      enableWineWayland = false;
      enableWoW64 = true;

      beforeLaunchScriptPath = "";
      afterLaunchScriptPath = "";

      framelessWindow = false;
      verboseLogs = true;
      downloadProtonToSteam = false;
      advertiseAvxForRosetta = false;

      noTrayIcon = false;
      showValveProton = false;

      disableSmoothScrolling = true;

      exitToTray = true;
      darkTrayIcon = false;
      discordRPC = true;
      maxRecentGames = 5;

      allTilesInColor = true;
      titlesAlwaysVisible = true;
    };
  };
in
{
  home.packages = [
    pkgs.heroic
  ];

  home.activation.setupHeroicConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    PATH="${pkgs.coreutils}/bin"
    ConfigDir="$HOME/.config/heroic"
    ConfigFile="$ConfigDir/config.json"

    # Создаем директорию, если её нет
    mkdir -p "$ConfigDir"

    # Копируем сгенерированный JSON (ключ -f перезапишет старый симлинк/файл)
    cp -f "${json.generate "heroic-config.json" heroicConfigStructure}" "$ConfigFile"
    
    # Делаем файл изменяемым для пользователя
    chmod u+w "$ConfigFile"
  '';
}
