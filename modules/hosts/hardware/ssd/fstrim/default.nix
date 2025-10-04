{ services, config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "fstrim";
  cfg = config.module.hardware.ssd.${name};
in {
  options.module.hardware.ssd.${name} = {
    enable = mkEnableOption "Enable fstrim";
  };

  config = mkIf cfg.enable {
    services.fstrim.enable = true;
  };
}
