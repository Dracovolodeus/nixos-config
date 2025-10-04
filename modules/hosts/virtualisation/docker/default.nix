{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "docker";
  cfg = config.module.virtualisation.${name};
in {
  options.module.virtualisation.${name} = {
    enable = mkEnableOption "Enable docker";
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
  };
}
