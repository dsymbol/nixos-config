{ config, pkgs, ... }:

{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580; # 1060 otherwise won't work
    powerManagement.enable = true; # fix display errors when resuming from suspend state
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
}
