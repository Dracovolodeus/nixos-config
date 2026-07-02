{ config, lib, ... }:
let
  stripHash =
    str: if builtins.substring 0 1 str == "#" then builtins.substring 1 (builtins.stringLength str - 1) str else str;

  mkThemeNoHash = theme: builtins.mapAttrs (_: v: stripHash v) theme;
in
{
  options.internal = {
    themePath = lib.mkOption {
      type = lib.types.path;
      default = ./catppuccin/mocha.nix;
    };

    theme = lib.mkOption {
      type = lib.types.attrs;
      readOnly = true;
    };
  };

  config = {
    internal.theme =
      let
        imported = import config.internal.themePath;

        moduleArgs = config._module.args or { };
        importedTheme = if builtins.isFunction imported then lib.callPackageWith moduleArgs imported { } else imported;
      in
      importedTheme // { colorsNoHash = mkThemeNoHash (importedTheme.colors or { }); };
  };
}
