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
      ...
    }@inputs:
    let
      username = "user";

      mkSystem =
        { host, system }: # function
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs username host; };
          modules = [
            {
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
                allowUnsupportedSystem = true;
              };
            }
            ./hosts/${host}/configuration.nix
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
