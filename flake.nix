{
  description = "NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    arkenfox-userjs = {
      url = "github:arkenfox/user.js";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      username = "user";

      mkSystem = import ./hosts {
        inherit
          nixpkgs
          inputs
          home-manager
          username
          ;
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
