{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) int;

  name = "swap";
  cfg = config.module.hardware.ram.${name};
in {
  options.module.hardware.ram.${name} = {
    enable = mkEnableOption "Enable swapfile";
    priority = mkOption {
      description = "Specify the priority of the swap device.";
      type = int;
      default = 999;
    };
    size = mkOption {
      description = "swapfile size in mb";
      type = int;
      default = 16384;
    };
  };

  config = mkIf cfg.enable {
    swapDevices = [{
      device = "/swapfile";
      priority = cfg.priority;
      size = cfg.size;
    }];
  };
}
