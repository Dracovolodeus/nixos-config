{
  pkgs,
  lib,
  user,
  ...
}:
let
  neovimExe = lib.getExe pkgs.neovim;
  ldsExe = lib.getExe pkgs.lsd;
  fastfetchExe = lib.getExe pkgs.fastfetch;
  homeManagerExe = lib.getExe pkgs.home-manager;
  gitExe = lib.getExe pkgs.git;
  dockerExe = lib.getExe pkgs.docker;
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
      n = "${neovimExe}";
      c = "clear";
      l = "${ldsExe}";
      ff = "${fastfetchExe}";

      # Config
      snc = "cd /nixos-config";
      suhmd = "cd /nixos-config/features/users/${user}/home-manager";
      swuhm = "${gitExe} -C /nixos-config add /nixos-config/features/users/${user} /nixos-config/features/modules/home-manager; ${homeManagerExe} switch -b backup --flake /nixos-config#${user}";

      # Git
      g = "${gitExe}";
      ga = "${gitExe} add";
      gs = "${gitExe} status";
      gc = "${gitExe} commit";
      gcm = "${gitExe} commit -m";
      gcad = "${gitExe} commit --amend";
      grmdo = "${gitExe} remote add origin";
      gps = "${gitExe} push";
      gpl = "${gitExe} pull";
      glo = "${gitExe} log --oneline";

      # Docker
      d = "${dockerExe}";
      dst = "${dockerExe} start";
      dsp = "${dockerExe} stop";
      dr = "${dockerExe} run";
      drm = "${dockerExe} rm";
      drmf = "${dockerExe} rm -f";
      dp = "${dockerExe} ps";
      dpa = "${dockerExe} ps -a";
    };
  };
}
