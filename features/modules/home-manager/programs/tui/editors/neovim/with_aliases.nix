{ pkgs, lib, ... }: let
    neovimExe = lib.getExe pkgs.neovim;
in {
  imports = [ ./default.nix ];
  home.shellAliases.n = neovimExe;
}
