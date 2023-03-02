{ pkgs, user, host, ... }:

{
  boot.loader.grub.device = "/dev/sda";

  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.enable = true;
  };

}
