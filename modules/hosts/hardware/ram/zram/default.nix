{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) int;

  name = "zram";
  cfg = config.module.hardware.ram.${name};
in {
  options.module.hardware.ram.${name} = {
    enable = mkEnableOption "Enable zram";
    memoryPercent = mkOption {
      description = "Maximum total amount of memory that can be stored in the zram swap devices (as a percentage of your total memory).";
      type = int;
      default = 100;
    };
    priority = mkOption {
      description = "Priority of the zram swap devices.";
      type = int;
      default = 1000;
    };
  };

  config = mkIf cfg.enable {
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = cfg.memoryPercent;
      priority = cfg.priority;
    };
  };
}
