{ inputs, pkgs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.lutris = {
    enable = true;
    package = pkgs.lutris;
    extraPackages = [ unstable.umu-launcher ];
  };
}
