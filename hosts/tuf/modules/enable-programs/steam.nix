{
  nixpkgs = {
    config = {
      packageOverrides = pkgs: {
        steam = pkgs.steam.override {
          extraPkgs = pkgs: with pkgs; [
            krb5.out
            xorg.libXau.out
            xorg.libXcomposite.out
            xorg.libXdamage.out
            xorg.libXdmcp.out
            xorg.libXfixes.out
            xorg.libXrandr.out
            xorg.libXrender.out
            xorg.libXtst.out
            nss
          ];
        };
      };
    };
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
