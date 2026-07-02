{ pkgs, ... }: {
  home.packages = with pkgs; [
    jdk21
    gradle_8
    maven
  ];
}
