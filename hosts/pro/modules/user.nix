{ pkgs, ... }: {

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.meowta = {
      isNormalUser = true;
      description = "Meowta";
      extraGroups = [ "networkmanager" "wheel" "video" "lp" "docker" "vboxusers" ];
      shell = pkgs.fish;
      packages = with pkgs; [ ];
    };
  };
  nix.settings.trusted-users = [ "root" "meowta" ];
}
