{
  pkgs,
  lib,
  username,
  ...
}:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;

  environment.systemPackages = with pkgs; [
    gnome-terminal
    nautilus
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  programs.dconf.profiles.${username}.databases = [
    {
      lockAll = true;
      settings = {
        "org/gnome/desktop/interface".color-scheme = "prefer-dark";
        # dock favorite apps
        "org/gnome/shell".favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "org.gnome.Terminal.desktop"
        ];
        # "org/gnome/mutter".dynamic-workspaces = false;
        # "org/gnome/desktop/wm/preferences".num-workspaces = lib.gvariant.mkUint32 1;
        "org/gnome/desktop/notifications".show-in-lock-screen = false;
        # mouse accel off
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
        # keyboard input langs
        "org/gnome/desktop/input-sources" = {
          sources = [
            (lib.gvariant.mkTuple [
              "xkb"
              "us"
            ])
            (lib.gvariant.mkTuple [
              "xkb"
              "il"
            ])
          ];
        };
        # screen blank 10m
        "org/gnome/desktop/session".idle-delay = lib.gvariant.mkUint32 600;
        # automatic suspend 2h
        "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-timeout = lib.gvariant.mkUint32 7200;

        "org/gnome/settings-daemon/plugins/media-keys" = {
          play = [ "F9" ];
          previous = [ "F10" ];
          next = [ "F11" ];
          volume-mute = [ "F12" ];
        };
      };
    }
  ];
}
