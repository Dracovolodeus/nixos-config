{ config, lib, pkgs, ... }:
let
  cfg = config.programs.lutrisSandbox;
  unwrapped = pkgs.flake.gui."lutris-sandbox".default;
  launcher = pkgs.writeShellApplication {
    name = "lutris-sandbox";
    runtimeInputs = [ unwrapped ];
    text = ''
      export LUTRIS_SANDBOX_LIBRARY_ROOT=${lib.escapeShellArg cfg.libraryRoot}
      export LUTRIS_SANDBOX_STATE_ROOT=${lib.escapeShellArg cfg.stateRoot}
      exec ${lib.getExe unwrapped} "$@"
    '';
  };
in
{
  options.programs.lutrisSandbox = {
    enable = lib.mkEnableOption "per-game Lutris sandboxing";

    libraryRoot = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/Games";
      description = "Root directory containing one directory per sandboxed game.";
    };

    stateRoot = lib.mkOption {
      type = lib.types.str;
      default = "${config.home.homeDirectory}/.local/state/lutris-sandbox";
      description = "Persistent private state for sandboxed games.";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = lib.hasPrefix "/" cfg.libraryRoot;
        message = "programs.lutrisSandbox.libraryRoot must be an absolute path.";
      }
      {
        assertion = lib.hasPrefix "/" cfg.stateRoot;
        message = "programs.lutrisSandbox.stateRoot must be an absolute path.";
      }
    ];

    home.packages = [ launcher ];

    programs.lutris.extraPackages = [ launcher ];
  };
}
