{ ... }:

{
  imports = [
    ./user.nix
    ./system.nix
    ./network.nix
    ./pipewire.nix
    ./bootloader.nix
  ];
}
