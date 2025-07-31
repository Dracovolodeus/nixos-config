{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    shellAliases = {
      cls = "clear";
      n = "nvim";
      g = "git";
      snc = "cd /nixos-config";
      suhmd = "cd /nixos-config/users/$USER/home-manager";
      swuhm = "git add .; home-manager switch --flake ./#$USER";
    };
  };
}
