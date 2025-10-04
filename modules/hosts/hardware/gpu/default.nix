{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "gpu";
  cfg = config.module.hardware.${name};
in {
  options.module.hardware.${name} = {
    enable = mkEnableOption "Enable gpu";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
