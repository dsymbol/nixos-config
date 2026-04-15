{
  pkgs,
  ...
}:

# https://nix-community.github.io/plasma-manager/options.xhtml
# to avoid logging out every time after applying run
# rm -R ~/.local/share/plasma-manager/last_run_script_* && ~/.local/share/plasma-manager/run_all.sh

{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      clickItemTo = "select";
      wallpaper = pkgs.nixos-artwork.wallpapers.simple-dark-gray.kdeFilePath;
    };

    kscreenlocker.appearance.wallpaper = pkgs.nixos-artwork.wallpapers.simple-dark-gray.kdeFilePath;
    
    panels = [
      {
        location = "bottom";
        height = 44;
        floating = false;
        widgets = [
          {
            kickoff = {
              icon = "nix-snowflake";
            };
          }
          {
            iconTasks = {
              launchers = [
                "preferred://filemanager"
                "applications:firefox.desktop"
                "applications:org.kde.kate.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:codium.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.pager"
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              time.format = "24h";
            };
          }
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    input.keyboard.layouts = [
      {
        layout = "us";
      }
      {
        layout = "il";
      }
    ];

    shortcuts = {
      mediacontrol.playpausemedia = [
        "Media Play"
        "F9"
      ];
      mediacontrol.previousmedia = [
        "Media Previous"
        "F10"
      ];
      mediacontrol.nextmedia = [
        "Media Next"
        "F11"
      ];
      kmix.mute = [
        "Volume Mute"
        "F12"
      ];
    };

    kscreenlocker.autoLock = false;
    kscreenlocker.timeout = 0;

    powerdevil.AC.powerProfile = "performance";
    powerdevil.AC.autoSuspend.action = "sleep";
    powerdevil.AC.autoSuspend.idleTimeout = 3600; # hour
    powerdevil.AC.dimDisplay.enable = false;
    powerdevil.AC.turnOffDisplay.idleTimeout = 600; # 10 minutes

    session.general.askForConfirmationOnLogout = false;
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    configFile = {
      kdeglobals.KDE.DndBehavior = "MoveIfSameDevice";
      klipperrc.General.KeepClipboardContents = false;
    };
  };
}
