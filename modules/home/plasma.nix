{
  pkgs,
  ...
}:

# https://nix-community.github.io/plasma-manager/options.xhtml

let
  wallpaper = pkgs.fetchurl {
    url = "https://files.catbox.moe/b9x0en.png";
    sha256 = "045b04p1lw0jbhr8vycvg672v3pv1k9fbz6vv5jd984zf5rgayyh";
  };

  # Avoid logging out every time after applying changes. ref: @NovaViper
  reload-plasma = pkgs.writeShellScriptBin "reload-plasma" ''
    rm -R ~/.local/share/plasma-manager/last_run_script_* && ~/.local/share/plasma-manager/run_all.sh
  '';
in
{
  home.packages = [
    reload-plasma
    pkgs.papirus-icon-theme
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      clickItemTo = "select";
      wallpaper = "${wallpaper}";
      iconTheme = "Papirus-Dark";
    };

    kscreenlocker.appearance.wallpaper = "${wallpaper}";

    panels = [
      {
        location = "bottom";
        height = 44;
        floating = false;
        widgets = [
          # https://github.com/nix-community/plasma-manager/tree/trunk/modules/widgets
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
              behavior.grouping = {
                method = "byProgramName";
                clickAction = "showTooltips";
              };
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.pager"
          {
            systemTray.items = {
              shown = [
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
              hidden = [
                "org.kde.plasma.clipboard"
                "org.kde.plasma.brightness"
              ];
            };
          }
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
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Shift";
      "mediacontrol"."playpausemedia" = ["Media Play" "F9"];
      "mediacontrol"."previousmedia" = ["Media Previous" "F10"];
      "mediacontrol"."nextmedia" = ["Media Previous" "F11"];
      "kmix"."mute" = ["Media Previous" "F12"];
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
