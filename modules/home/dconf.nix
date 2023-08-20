{ pkgs, lib, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    # dock favorite apps
    "org/gnome/shell".favorite-apps = [
      "org.gnome.Nautilus.desktop"
      "firefox.desktop"
      "org.gnome.Terminal.desktop"
    ];
    "org/gnome/desktop/notifications".show-in-lock-screen = false;
    # mouse accel off
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    # screen blank 10m
    "org/gnome/desktop/session".idle-delay = lib.hm.gvariant.mkUint32 600;
    # automatic suspend 2h
    "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-timeout = lib.hm.gvariant.mkUint32 7200;

    "org/gnome/settings-daemon/plugins/media-keys" = {
      play = [ "F9" ];
      previous = [ "F10" ];
      next = [ "F11" ];
      volume-mute = [ "F12" ];
    };

    # keyboard input langs
    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "us"
        ])
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "il"
        ])
      ];
    };
  };
}
