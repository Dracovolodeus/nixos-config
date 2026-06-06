{ pkgs, stateVersion, hostName, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules
  ];

  system.stateVersion = stateVersion;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  services.zerotierone.enable = true;
  programs.dconf.enable = true;
  programs.throne.enable = true;
  programs.throne.tunMode.enable = true;
  services.upower.enable = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    wl-clipboard
    home-manager
    neovim
    git
  ];
}
