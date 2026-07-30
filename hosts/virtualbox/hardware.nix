{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  config = {
    boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-partlabel/root";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-partlabel/boot";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [ ];

    zramSwap.enable = true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  };

  options.partition = lib.mkOption {
    type = lib.types.package;
    default = pkgs.writeShellApplication {
      name = "partition";
      text = ''
        disk="/dev/sda"

        parted -s "$disk" -- mklabel gpt
        parted -s "$disk" -- mkpart boot fat32 1MiB 512MiB
        parted -s "$disk" -- mkpart root 512MiB 100%
        parted -s "$disk" -- set 1 esp on

        mkfs.vfat -F 32 "$disk"1 -n boot
        mkfs.ext4 "$disk"2 -L root

        udevadm trigger --subsystem-match=block; udevadm settle

        mount -t ext4 /dev/disk/by-partlabel/root /mnt
        mkdir -p /mnt/boot
        mount /dev/disk/by-partlabel/boot /mnt/boot
      '';
    };
  };
}
