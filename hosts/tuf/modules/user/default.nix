{ pkgs, ... }: {

  programs.fish.enable = true;

  users = {
    users.draco = {
      isNormalUser = true;
      description = "Draco";
      extraGroups = [ "wheel" "docker" ];
      shell = pkgs.fish;
      packages = with pkgs; [ ];
    };
  };
  nix.settings.trusted-users = [ "root" "draco" ];
}
