{ config, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "steam";
  cfg = config.module.gaming.${name};
in {
  options.module.gaming.${name} = {
    enable = mkEnableOption "Enable steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    nixpkgs = {
      config = {
        packageOverrides = pkgs: {
          steam = pkgs.steam.override {
            extraPkgs = pkgs: with pkgs; [
              krb5
              libXau
              libXcomposite
              libXdamage
              libXdmcp
              libXfixes
              libXrandr
              libXrender
              libXtst
              nss
            ];
          };
        };
      };
    };
  };
}


