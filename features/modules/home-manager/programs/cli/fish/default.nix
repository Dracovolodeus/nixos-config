{
  pkgs,
  lib,
  user,
  ...
}:
let
  homeManagerExe = lib.getExe pkgs.home-manager;
  gitExe = lib.getExe pkgs.git;
in
{
  home.sessionVariables = {
    SHELL = "fish";
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      set -U fish_greeting
    '';

    shellAliases = {
      # Basic
      c = "clear";

      # Config
      snc = "cd /nixos-config";
      suhmd = "cd /nixos-config/features/users/${user}/home-manager";
      swuhm = "${gitExe} -C /nixos-config add /nixos-config/features/users/${user} /nixos-config/features/modules/home-manager; ${homeManagerExe} switch -b backup --flake /nixos-config#${user}";
    };
  };
}
