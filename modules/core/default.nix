{ ... }:

{
  imports = [
    ./user.nix
    ./system.nix
    ./docker.nix
    ./network.nix
    ./pipewire.nix
    ./bootloader.nix
  ];
}
