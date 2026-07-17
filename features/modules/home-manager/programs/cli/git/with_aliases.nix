{ pkgs, lib, ... }: let
  gitExe = lib.getExe pkgs.git;
in {
  imports = [ ./default.nix ];
  home.shellAliases = {
      g = "${gitExe}";
      ga = "${gitExe} add";
      gaa = "${gitExe} add -A";
      gs = "${gitExe} status";
      gc = "${gitExe} commit";
      gcm = "${gitExe} commit -m";
      gcad = "${gitExe} commit --amend";
      grmdo = "${gitExe} remote add origin";
      gps = "${gitExe} push";
      gpl = "${gitExe} pull";
      glo = "${gitExe} log --oneline";
    };
}
