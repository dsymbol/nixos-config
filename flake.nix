{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

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

    jail-nix.url = "sourcehut:~alexdavid/jail.nix";
  };

  outputs = { nixpkgs, ... }@inputs:
    let
      username = "user";

      mkSystem = host: system:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/${host}/configuration.nix
          ];
          specialArgs = {
            inherit inputs username host;
          };
        };
    in
    {
      nixosConfigurations.desktop = mkSystem "desktop" "x86_64-linux";
      nixosConfigurations.thinkpad = mkSystem "thinkpad" "x86_64-linux";
      nixosConfigurations.virtualbox = mkSystem "virtualbox" "x86_64-linux";
    };
}
