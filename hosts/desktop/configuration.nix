{ pkgs, username, ... }:

{
  imports = [
    ../../modules/core/gpu.nix
    ../../modules/core/kde.nix
  ];

  virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "${username}" ];

  powerManagement = {
    cpuFreqGovernor = "performance";
    # suspend fix
    powerDownCommands = ''
      ${pkgs.gawk}/bin/awk '/\\*enabled/ {print $1}' /proc/acpi/wakeup | \
      ${pkgs.findutils}/bin/xargs -I {} ${pkgs.bash}/bin/bash -c 'echo {} > /proc/acpi/wakeup'
    '';
  };
}
