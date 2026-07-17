{ pkgs, lib, ... }: let
  dockerExe = lib.getExe pkgs.docker;
in {
  imports = [ ./default.nix ];
  home.shellAliases = {
    d = "${dockerExe}";
    dst = "${dockerExe} start";
    dsp = "${dockerExe} stop";
    dr = "${dockerExe} run";
    drm = "${dockerExe} rm";
    drmf = "${dockerExe} rm -f";
    dp = "${dockerExe} ps";
    dpa = "${dockerExe} ps -a";
    dc = "${dockerExe} compose";
    dcu ="${dockerExe} compose up"; 
    dcub ="${dockerExe} compose up --build"; 
  };

}
