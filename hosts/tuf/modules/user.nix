{ pkgs, ... }: {

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.draco = {
      isNormalUser = true;
      description = "Draco";
      extraGroups = [ "wheel" "networkmanager" "docker" "video" "plugdev" ];
      shell = pkgs.fish;
      packages = with pkgs; [ ];
    };
  };
  nix.settings.trusted-users = [ "root" "draco" ];
}
