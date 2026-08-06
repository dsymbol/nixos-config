{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05"; # https://status.nixos.org/

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

  outputs = { nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      username = "user";

      mkSystem = host: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./hosts/${host}/configuration.nix
          ];
          specialArgs = {
            inherit inputs username host;
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
          };
        };
    in
    {
      nixosConfigurations.desktop = mkSystem "desktop" "x86_64-linux";
      nixosConfigurations.virtualbox = mkSystem "virtualbox" "x86_64-linux";
    };
}
