{
  pkgs,
  lib,
  username,
  ...
}:

let
  defaults = lib.importJSON "${pkgs.noctalia-shell}/share/noctalia-shell/Assets/settings-default.json";
  widgetDefaults = lib.importJSON "${pkgs.noctalia-shell}/share/noctalia-shell/Assets/settings-widgets-default.json";
  mkWidget = widget: lib.recursiveUpdate (widgetDefaults.bar.${widget.id} or { }) widget;

  qmlMatch = builtins.match ".*readonly property int settingsVersion: +([0-9]+).*" (
    builtins.readFile "${pkgs.noctalia-shell}/share/noctalia-shell/Commons/Settings.qml"
  );
  currentSettingsVersion = lib.strings.toInt (builtins.elemAt qmlMatch 0);

  mPowerOpts = map (
    item:
    if
      item.action == "hibernate" || item.action == "rebootToUefi" || item.action == "userspaceReboot"
    then
      item // { enabled = false; }
    else
      item
  ) defaults.sessionMenu.powerOptions;

  mControlCards = map (
    item:
    if item.id == "brightness-card" then
      item // { enabled = true; }
    else if item.id == "weather-card" || item.id == "media-sysmon-card" then
      item // { enabled = false; }
    else
      item
  ) defaults.controlCenter.cards;
in
{
  xdg.configFile."noctalia/settings.json".text = builtins.toJSON (
    lib.recursiveUpdate defaults {
      settingsVersion = currentSettingsVersion;

      colorSchemes.predefinedScheme = "Tokyo Night";
      dock.enabled = false;
      notifications.density = "compact";
      controlCenter.cards = mControlCards;
      location.weatherEnabled = false;

      appLauncher = {
        showCategories = false;
        enableSettingsSearch = false;
      };

      wallpaper = {
        directory = "/home/${username}/Pictures/Wallpapers";
        skipStartupTransition = true;
      };

      bar = {
        barType = "floating";
        density = "comfortable";
        marginHorizontal = 8;
        marginVertical = 8;
        position = "bottom";
        showCapsule = false;
      };

      bar.widgets = {
        left = map mkWidget [
          {
            id = "Launcher";
            useDistroLogo = true;
          }
          {
            id = "ActiveWindow";
            maxWidth = 250;
          }
        ];

        center = map mkWidget [
          { id = "Workspace"; }
          {
            id = "MediaMini";
            compactMode = true;
            showAlbumArt = false;
            showProgressRing = false;
          }
        ];

        right = map mkWidget [
          {
            id = "Tray";
            pinned = [
              "Telegram Desktop"
            ];
          }
          { id = "NotificationHistory"; }
          {
            id = "Battery";
            showPowerProfiles = true;
          }
          { id = "Volume"; }
          { id = "Network"; }
          { id = "KeyboardLayout"; }
          { id = "ControlCenter"; }
          {
            id = "Clock";
            formatHorizontal = "HH:mm";
          }
          { id = "SessionMenu"; }
        ];
      };

      general = {
        clockFormat = "HH\nmm";
        clockStyle = "digital";
        compactLockScreen = true;
        enableLockScreenCountdown = false;
        telemetryEnabled = false;
        enableBlurBehind = false;
      };

      idle = {
        enabled = true;
        lockTimeout = 1750;
      };

      sessionMenu = {
        enableCountdown = false;
        largeButtonsStyle = false;
        position = "bottom_right";
        showHeader = false;
        showKeybinds = false;
        powerOptions = mPowerOpts;
      };

      ui = {
        fontDefault = "JetBrainsMono Nerd Font";
        fontFixed = "JetBrainsMono Nerd Font Mono";
      };
    }
  );
}
