{ config, lib, pkgs, ... }: let
  inherit (lib) mkEnableOption mkOption mkIf;
  inherit (lib.types) str listOf;

  name = "boot";
  cfg = config.module.system.${name};
in {
  options.module.system.${name} = {
    enable = mkEnableOption "Enable boot params";

    kernelPackages = mkOption {
      description = "Choice kernel";
      default = "linuxPackages_latest";
      type = str;
    };

    kernelParams = mkOption {
      description = "Choice kernel params";
      default = [
        "quiet"
        "splash"
        "preempt=full"
      ];
      type = listOf str;
    };
  };

  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.${cfg.kernelPackages};
      kernelParams = cfg.kernelParams;

      loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          enable = true;
          devices = [ "nodev" ];
          efiSupport = true;
          useOSProber = true;
        };
      };
      tmp.cleanOnBoot = true;
    };
  };
}
