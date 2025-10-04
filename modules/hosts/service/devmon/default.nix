{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "devmon";
  cfg = config.module.service.${name};
in {
  options.module.service.${name} = {
    enable = mkEnableOption "Enable devmon";
  };

  config = mkIf cfg.enable {
    services.devmon.enable = true;
  };
}
