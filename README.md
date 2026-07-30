# nixos-config

This repository contains my NixOS configurations.

## Installation

```bash
git clone https://github.com/dsymbol/nixos-config
cd nixos-config
sudo nix run --extra-experimental-features "nix-command flakes" .#nixosConfigurations.virtualbox.config.partition
sudo nixos-install --flake .#virtualbox
reboot
```

## Acknowledgements

[Baitinq](https://github.com/Baitinq/nixos-config) for contributions and assistance.
