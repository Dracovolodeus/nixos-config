{ pkgs, var, ... }: {
  programs.fish = {
    enable = true;

    shellInit = ''
      set -U fish_greeting
    '';

    shellAliases = {
      # Basic
      c = "clear";
      n = "nvim";

      # Git
      g = "git";
      ga = "git add";
      gs = "git status";
      gc = "git commit";
      gps = "git push";
      gpl = "git pull";

      # Docker
      d = "docker";
      dr = "docker run";
      drm = "docker rm";
      drmf = "docker rm -f";
      dp = "docker ps";
      dpa = "docker ps -a";

      snc = "cd /nixos-config";
      suhmd = "cd /nixos-config/users/${var.user}/home-manager";
      swuhm = "git add users/${var.user}; home-manager switch --flake ./#${var.user}";
    };
  };
}
