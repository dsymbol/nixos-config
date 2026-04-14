{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

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

      nixosConfigurations.vmware = mkSystem {
        host = "vmware";
        system = "x86_64-linux";
      };

      nixosConfigurations.virtualbox = mkSystem {
        host = "virtualbox";
        system = "x86_64-linux";
      };
    };
}
