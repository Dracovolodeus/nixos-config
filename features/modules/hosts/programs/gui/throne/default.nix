{ pkgs, ... }: {
  programs.throne = {
    package = pkgs.flake.gui.throne.last_version;
    enable = true;
    tunMode.enable = true;
  };
}
