{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  config = {
    boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/mapper/cryptroot";
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

    boot.initrd.luks.devices."cryptroot" = {
      device = "/dev/disk/by-partlabel/root";
      allowDiscards = true; # Due to SSD
    };

    swapDevices = [ ];

    zramSwap.enable = true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  options.partition = lib.mkOption {
    type = lib.types.package;
    default = pkgs.writeShellApplication {
      name = "partition";
      text = ''
        disk="/dev/nvme0n1"

        parted -s "$disk" -- mklabel gpt
        parted -s "$disk" -- mkpart boot fat32 1MiB 512MiB
        parted -s "$disk" -- mkpart root 512MiB 100%
        parted -s "$disk" -- set 1 esp on

        cryptsetup luksFormat -q --type luks2 "$disk"p2
        cryptsetup open "$disk"p2 cryptroot

        mkfs.vfat -F 32 "$disk"p1
        mkfs.ext4 /dev/mapper/cryptroot

        udevadm trigger --subsystem-match=block; udevadm settle

        mount -t ext4 /dev/mapper/cryptroot /mnt
        mkdir -p /mnt/boot
        mount /dev/disk/by-partlabel/boot /mnt/boot
      '';
    };
  };
}
