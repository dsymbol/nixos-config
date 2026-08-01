{ pkgs, config, username, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/core/kde.nix
    ../../modules/core/podman.nix
    ../../modules/core/nvidia.nix
    ../../modules/core/virtualbox.nix
    ../../modules/core/libreoffice.nix
  ];

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580; # 1060 otherwise won't work
  boot.loader.grub.useOSProber = true; # dual boot

  services.displayManager.autoLogin = {
    enable = true;
    user = username;
  };
  
  powerManagement = {
    cpuFreqGovernor = "performance";
    # suspend fix
    powerDownCommands = ''
      ${pkgs.gawk}/bin/awk '/\\*enabled/ {print $1}' /proc/acpi/wakeup | \
      ${pkgs.findutils}/bin/xargs -I {} ${pkgs.bash}/bin/bash -c 'echo {} > /proc/acpi/wakeup'
    '';
  };

  # fixes 3.5mm analog combo jack splitter (headphone + mic).
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=dell-headset-multi
  '';
}
