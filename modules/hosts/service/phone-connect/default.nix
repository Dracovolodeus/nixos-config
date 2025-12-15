{ pkgs, config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "phone-connect";
  cfg = config.module.service.${name};
in {
  options.module.service.${name} = {
    enable = mkEnableOption "Enable phone-connect";
  };

  config = mkIf cfg.enable {

    # services.udev.packages = [ pkgs.android-udev-rules ];
    services.gvfs.enable = true;
    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
      mtpfs
    ];
  };
}

