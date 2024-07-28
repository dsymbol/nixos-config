# nixos-config

This repository contains my NixOS configurations.

## Installation

```bash
sudo -i
git clone https://github.com/dsymbol/nixos-config
cd nixos-config
bash ./scripts/partition.sh
nixos-install --flake .#vmware
reboot
```

## Acknowledgements

[Baitinq](https://github.com/Baitinq/nixos-config) for contributions and assistance.
