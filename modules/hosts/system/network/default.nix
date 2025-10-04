{ config, lib, hostName, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "network";
  cfg = config.module.system.${name};
in {
  options.module.system.${name} = {
    enable = mkEnableOption "Enable networkmanager";
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = hostName;
      networkmanager.enable = true;
    };
  };
}
