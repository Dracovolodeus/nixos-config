{ pkgs, ... }: {

  programs.fish.enable = true;

  users = {
    users.meowta = {
      isNormalUser = true;
      description = "Meowta";
      extraGroups = [ "networkmanager" "wheel" "video" "lp" "docker" ];
      shell = pkgs.fish;
      packages = with pkgs; [ ];
    };
  };
  nix.settings.trusted-users = [ "root" "meowta" ];
}
