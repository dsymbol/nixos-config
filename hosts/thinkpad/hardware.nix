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
    boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
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

    swapDevices = [{
      device = "/var/lib/swapfile";
      size = 16*1024;
    }];

    zramSwap.enable = true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
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
