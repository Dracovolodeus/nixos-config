{ config, lib, hostName, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) int listOf;

  name = "network";
  cfg = config.module.system.${name};
in {
  options.module.system.${name} = {
    enable = mkEnableOption "Enable networkmanager";

    enableFirewall = mkEnableOption {
      description = "Enable firewall";
      default = true;
    };
    allowPing = mkEnableOption {
      description = "Enable allow ping";
      default = false;
    };
    allowedTCPPorts = mkOption {
      description = "Allowed TCP ports";
      default = [ ];
      type = listOf int;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = hostName;
      networkmanager.enable = true;
      firewall = {
        enable = cfg.enableFirewall;
        allowedTCPPorts = cfg.allowedTCPPorts;
        allowPing = cfg.allowPing;
      };
    };
  };
}
