{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "udisks2";
  cfg = config.module.service.${name};
in {
  options.module.service.${name} = {
    enable = mkEnableOption "Enable udisks2";
  };

  config = mkIf cfg.enable {
    services.udisks2.enable = true;
  };
}
