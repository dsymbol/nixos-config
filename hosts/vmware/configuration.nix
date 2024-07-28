{ pkgs, username, ... }:

{
  imports = [
    ./../../modules/core/kde.nix
  ];
  
  networking.firewall.enable = false;
  services.openssh.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = username;

  services.xserver.videoDrivers = [ "vmware" ];
  virtualisation.vmware.guest.enable = true;
  
  # wayland slow in vmware
  services.xserver.enable = true;
  services.displayManager.defaultSession = "plasmax11";
  services.displayManager.sddm.wayland.enable = false;
}
