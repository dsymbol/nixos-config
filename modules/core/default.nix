{ ... }:

{
  imports = [
    ./user.nix
    ./brave.nix
    ./system.nix
    ./network.nix
    ./pipewire.nix
    ./bootloader.nix
  ];
}
