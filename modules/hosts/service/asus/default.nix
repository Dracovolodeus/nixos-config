{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "asus";
  cfg = config.module.service.${name};
in {
  options.module.service.${name} = {
    enable = mkEnableOption "Enable asusd daemon";
  };

  config = mkIf cfg.enable {
    services = {
      asusd = {
        enable = true;
        enableUserService = true;
      };
      supergfxd = {
        enable = true;
      };
    };
  };
}
