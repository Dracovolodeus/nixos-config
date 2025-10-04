{ config, pkgs, lib, ... }: let
  inherit (lib) mkEnableOption mkIf;

  name = "nix-ld";
  cfg = config.module.dev.${name};
in {
  options.module.dev.${name} = {
    enable = mkEnableOption "Enable nix-ld";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
      libgcc
    ];
  };
}
