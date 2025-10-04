{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) str;

  name = "locale";
  cfg = config.module.system.${name};
in {
  options.module.system.${name} = {
    enable = mkEnableOption "configuring locales";
    locale = mkOption {
      description = "Choice locales";
      default = "ru_RU.UTF-8";
      type = str;
    };
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = cfg.locale;

    i18n.extraLocaleSettings = {
      LC_ADDRESS = cfg.locale;
      LC_IDENTIFICATION = cfg.locale;
      LC_MEASUREMENT = cfg.locale;
      LC_MONETARY = cfg.locale;
      LC_NAME = cfg.locale;
      LC_NUMERIC = cfg.locale;
      LC_PAPER = cfg.locale;
      LC_TELEPHONE = cfg.locale;
      LC_TIME = cfg.locale;
    };
  };
}
