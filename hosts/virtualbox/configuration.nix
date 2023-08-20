{ pkgs, username, ... }:

{
  imports = [
    ./../../modules/core/gnome.nix
  ];
  
  networking.firewall.enable = false;
  services.openssh.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = username;

  virtualisation.virtualbox.guest.enable = true;
}
