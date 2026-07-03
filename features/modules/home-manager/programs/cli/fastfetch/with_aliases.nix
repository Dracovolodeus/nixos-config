{ pkgs, lib, ... }: let
  fastfetchExe = lib.getExe pkgs.fastfetch;
in {
  imports = [ ./default.nix ];
  home.shellAliases.ff = fastfetchExe;
}
