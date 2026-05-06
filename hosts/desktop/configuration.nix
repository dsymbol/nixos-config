{ pkgs, username, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/core/kde.nix
    ../../modules/core/nvidia.nix
    ../../modules/core/virtualbox.nix
  ];

  boot.loader.grub.useOSProber = true; # dual boot

  powerManagement = {
    cpuFreqGovernor = "performance";
    # suspend fix
    powerDownCommands = ''
      ${pkgs.gawk}/bin/awk '/\\*enabled/ {print $1}' /proc/acpi/wakeup | \
      ${pkgs.findutils}/bin/xargs -I {} ${pkgs.bash}/bin/bash -c 'echo {} > /proc/acpi/wakeup'
    '';
  };
}
