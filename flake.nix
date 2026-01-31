{
  description = "Dracovolodeus flake setup";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    freesmlauncher = {
      url = "github:FreesmTeam/FreesmLauncher/update_flake_lock_action";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      users = [
        {userName = "draco"; homeStateVersion = "25.11"; system = "x86_64-linux"; }
      ];
      hosts = [
        { hostName = "tuf"; stateVersion = "25.11"; system = "x86_64-linux"; }
      ];
    in
      {
      nixosConfigurations = builtins.listToAttrs (map
        (host: {
          name = host.hostName;
          value = nixpkgs.lib.nixosSystem {
            system = host.system;
            modules = [
              ./hosts/${host.hostName}/configuration.nix
              ./modules/hosts
            ];
            specialArgs = { inherit inputs; stateVersion = host.stateVersion; hostName = host.hostName; };
          };
        })
        hosts);

      homeConfigurations = builtins.listToAttrs (map
        (user: {
          name = user.userName;
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${user.system};
            modules = [
              ./users/${user.userName}/home-manager/home.nix
            ];
            extraSpecialArgs = {
              inherit inputs;
              homeStateVersion = user.homeStateVersion;
              user = user.userName;
              unstable = inputs.nixpkgs-unstable.legacyPackages.${user.system};
            };
          };
        })
        users);
    };
}
