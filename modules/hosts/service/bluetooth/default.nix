{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "bluetooth";
  cfg = config.module.service.${name};
in {
  options.module.service.${name} = {
    enable = mkEnableOption "Enable bluetooth";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
