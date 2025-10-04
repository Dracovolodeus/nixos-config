{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "nix";
  cfg = config.module.system.${name};
in {
  options.module.system.${name} = {
    enable = mkEnableOption "Enable experimental-features";
  };

  config = mkIf cfg.enable {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
