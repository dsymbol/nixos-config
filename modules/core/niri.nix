{ pkgs, ... }:

{
  programs.niri.enable = true;

  security.polkit.enable = true;
  services.gvfs.enable = true;
  services.power-profiles-daemon.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = [
      "gnome"
      "gtk"
    ];
  };
}
