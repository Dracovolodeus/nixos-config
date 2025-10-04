{ user, homeStateVersion, ... }:
let
  var = import ./var.nix { inherit user; };
in
{
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;
  };

  imports = [
    ./home-packages.nix
    ./modules
  ];

  _module.args = {
    inherit var;
  };
}
