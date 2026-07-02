{ hostName, stateVersion, ... }: {
  system = {
    name = hostName;
    stateVersion = stateVersion;
  };

  imports = [
    ./audio
    ./boot
    ./networking
    ./nix
    ./nixpkgs
    ./i18n
    ./timezone
    ./users
  ];
}
