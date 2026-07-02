{
  description = "Dracovolodeus flake setup.";

  inputs = {

    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-26.05";
    };

    nixpkgs-unstable = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-26.05";
    };

    home-manager = {
      flake = true;
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    haumea = {
      flake = true;
      type = "github";
      owner = "nix-community";
      repo = "haumea";
    };

    freesmlauncher = {
      flake = true;
      type = "github";
      owner = "freesmteam";
      repo = "freesmlauncher";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      haumea,
      ...
    }@inputs:
    let
      hosts = [
        {
          # Asus Tuf A15
          hostName = "tuf";
          stateVersion = "25.11";
          system = "x86_64-linux";
        }
      ];

      users = [
        {
          userName = "draco";
          homeStateVersion = "25.11";
          system = "x86_64-linux";
        }
      ];

      modules = haumea.lib.load {
        src = ./features/modules;
        loader = haumea.lib.loaders.path;
      };
      hostsModules = modules.hosts;
      hmModules = modules.home-manager;

    in
    {
      nixosConfigurations = builtins.listToAttrs (
        map (host: {
          name = host.hostName;
          value = nixpkgs.lib.nixosSystem {
            system = host.system;
            modules = [ ./features/hosts/${host.hostName}/configuration.nix ];
            specialArgs = {
              inherit inputs hostsModules;
              stateVersion = host.stateVersion;
              hostName = host.hostName;
            };
          };
        }) hosts
      );

      homeConfigurations = builtins.listToAttrs (
        map (user: {
          name = user.userName;
          value = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${user.system};
            modules = [
              ./features/users/${user.userName}/home-manager/home.nix
              ./features/modules/home-manager/themes
            ];
            extraSpecialArgs = {
              inherit inputs hmModules;
              user = user.userName;
              homeStateVersion = user.homeStateVersion;
            };
          };
        }) users
      );

    };
}
