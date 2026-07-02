{
  pkgs,
  hostsModules,
  inputs,
  ...
}:
{
  imports = [
    hostsModules.programs.gui.steam.default
    hostsModules.programs.gui.throne.default
  ];

  environment.systemPackages = with pkgs; [
    inputs.home-manager.packages.${pkgs.stdenv.hostPlatform.system}.default
    neovim
    git
  ];
}
