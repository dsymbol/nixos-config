#!/usr/bin/env bash

echo "Warning: All data on set disk will be destroyed"

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo."
    exit 1
fi

echo "Available Disks:"
lsblk -d -o NAME,SIZE,TYPE | grep -E 'disk'

echo -n -e "\nEnter the disk (e.g., /dev/sda): "
read disk

if [ ! -b "${disk}" ]; then
    echo "${disk} is not a valid block device."
    exit 1
fi

if [[ "${disk}" == /dev/nvme* ]]; then
    p1="p1"
    p2="p2"
else
    p1="1"
    p2="2"
fi

if [ -d "/sys/firmware/efi" ]; then
    echo "UEFI detected."
    parted -s ${disk} -- mklabel gpt
    parted -s ${disk} -- mkpart ESP fat32 0% 500MiB
    parted -s ${disk} -- mkpart primary 500MiB 100%
    parted -s ${disk} -- set 1 esp on

    mkfs.vfat -F 32 ${disk}${p1} -n boot
    mkfs.ext4 ${disk}${p2} -L root

    udevadm trigger --subsystem-match=block
    udevadm settle
    mount -t ext4 /dev/disk/by-label/root /mnt
    mkdir -p /mnt/boot
    mount /dev/disk/by-label/boot /mnt/boot
else
    echo "BIOS detected."
    parted -s ${disk} -- mklabel msdos
    parted -s ${disk} -- mkpart primary 0% 100%
    parted -s ${disk} -- set 1 boot on

    mkfs.ext4 ${disk}${p1} -L root
    udevadm trigger --subsystem-match=block
    udevadm settle
    mount -t ext4 /dev/disk/by-label/root /mnt
fi

lsblk ${disk} -o name,mountpoint,label,size,uuid
