{ config, pkgs, ... }:

{
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    powerManagement.enable = true; # fix display errors when resuming from suspend state
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
}
