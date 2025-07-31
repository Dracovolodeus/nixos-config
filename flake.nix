{
  description = "My Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      homeStateVersion = "25.05";
      users = [
        "draco"
      ];
      hosts = [
        { hostName = "pro"; stateVersion = "25.05"; }
        { hostName = "tuf"; stateVersion = "25.05"; }
      ];
    in
    {
      nixosConfigurations = builtins.listToAttrs (map
        (host: {
          name = host.hostName;
          value = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [ ./hosts/${host.hostName}/configuration.nix ];
            specialArgs = { inherit inputs; stateVersion = host.stateVersion; hostName = host.hostName; };
          };
        })
        hosts);

      homeConfigurations = builtins.listToAttrs (map
        (user: {
          name = user;
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${system};
            modules = [ ./users/${user}/home-manager/home.nix ];
            extraSpecialArgs = { inherit inputs user homeStateVersion; };
          };
        })
        users);
    };
}
