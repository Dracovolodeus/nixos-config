{ lib, user, homeStateVersion, ... }:
let
  var = import ./var.nix { inherit user; };
  hmSecretFile = "/etc/nix-secrets/hm-secrets.nix";
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
  ] ++ lib.optional (builtins.pathExists hmSecretFile) hmSecretFile;

  _module.args = {
    inherit var;
  };
}
