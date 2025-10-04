{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) str;

  name = "timezone";
  cfg = config.module.system.${name};
in {
  options.module.system.${name} = {
    enable = mkEnableOption "configuring timezone";
    timeZone = mkOption {
      description = "Choice timezone";
      default = "Asia/Barnaul";
      type = str;
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timeZone;
  };
}
