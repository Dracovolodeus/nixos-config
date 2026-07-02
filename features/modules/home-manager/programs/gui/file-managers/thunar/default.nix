{ pkgs, ... }: {
  home.packages = with pkgs; [
    thunar
    xfconf
  ];
}
