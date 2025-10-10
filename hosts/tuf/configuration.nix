{ pkgs, stateVersion, hostName, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = stateVersion;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.dconf.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    wl-clipboard
    home-manager
    neovim
    git
  ];
}
