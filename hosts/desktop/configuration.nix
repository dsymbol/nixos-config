{ pkgs, username, ... }:

{
  imports = [
    ./../../modules/core/gnome.nix
    ./../../modules/core/gpu.nix
  ];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
    # suspend fix
    powerDownCommands = ''
      ${pkgs.gawk}/bin/awk '/\\*enabled/ {print $1}' /proc/acpi/wakeup | \
      ${pkgs.findutils}/bin/xargs -I {} ${pkgs.bash}/bin/bash -c 'echo {} > /proc/acpi/wakeup'
    '';
  };
}
