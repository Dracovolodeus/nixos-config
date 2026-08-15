{ pkgs, ... }: {
  home.packages = [ pkgs.flake.cli.network.nsproxy.default ];
}
