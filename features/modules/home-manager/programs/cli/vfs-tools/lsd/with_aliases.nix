{ pkgs, lib, ... }: let
  lsdExe = lib.getExe pkgs.lsd;
in {
  imports = [ ./default.nix ];
  home.shellAliases.l = lsdExe;
}
