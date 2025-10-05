{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) str;

  name = "nvidia";
  cfg = config.module.hardware.gpu.${name};
in {
  options.module.hardware.gpu.${name} = {
    enable = mkEnableOption "Enable nvidia drivers";
    package = mkOption {
      description = "Choice version nvidia driver";
      type = str;
      default = "latest";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.${cfg.package};
      modesetting.enable = false;

      powerManagement = {
        enable = false;
        finegrained = false;
      };
    };
    powerManagement.enable = false;
  };
}
