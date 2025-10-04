{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "amd";
  cfg = config.module.hardware.cpu.${name};
in {
  options.module.hardware.cpu.${name} = {
    enable = mkEnableOption "Enable amd";
  };

  config = mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
