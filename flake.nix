{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    arkenfox-userjs = {
      url = "github:arkenfox/user.js";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      ...
    }@inputs:
    let
      username = "user";
      
      mkSystem = { host, system }: # function
        let
          inheritable = {
            inherit inputs username host;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = inheritable;
          modules = [
            # allow extra packages
            {
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
                allowUnsupportedSystem = true;
              };
            }

            # nixos related configuration
            ./hosts/configuration.nix
            ./hosts/${host}/hardware.nix
            ./hosts/${host}/configuration.nix

            # home-manager related configuration
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [ plasma-manager.homeModules.plasma-manager ];
                extraSpecialArgs = inheritable;
                users.${username} = {
                  imports = [
                    ./hosts/home.nix
                    ./hosts/${host}/home.nix
                  ];
                };
              };
            }
          ];
        };
    in
    {
      nixosConfigurations.desktop = mkSystem {
        host = "desktop";
        system = "x86_64-linux";
      };

      nixosConfigurations.virtualbox = mkSystem {
        host = "virtualbox";
        system = "x86_64-linux";
      };
    };
}
