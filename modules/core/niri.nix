{ pkgs, ... }:

{
  imports = [
    ./greetd.nix
  ];

  programs.niri.enable = true;

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
