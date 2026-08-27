{
  inputs,
  pkgs,
  ...
}:

# https://nix-community.github.io/plasma-manager/options.html

let
  # avoid logging out every time after applying changes. ref: @NovaViper
  reload-plasma = pkgs.writeShellScriptBin "reload-plasma" ''
    rm -R ~/.local/share/plasma-manager/last_run_script_* && ~/.local/share/plasma-manager/run_all.sh
  '';
in
{
  imports = [
    inputs.plasma-manager.homeModules.plasma-manager
    ./panels.nix
    ./programs.nix
    ./shortcuts.nix
    ./powerdevil.nix
    ./window-rules.nix
  ];

  home.packages = [
    reload-plasma
    pkgs.papirus-icon-theme
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      clickItemTo = "select";
      iconTheme = "Papirus-Dark";
    };

    kscreenlocker = {
      autoLock = false;
      timeout = 0;
    };

    kwin = {
      effects = {
        blur = {
          enable = true;
          noiseStrength = 0;
          strength = 3;
        };
      };
      
      titlebarButtons = {
        left = [ "more-window-actions" ];
        right = [
          "minimize"
          "maximize"
          "close"
        ];
      };
    };

    input.keyboard = {
      numlockOnStartup = "on";
      layouts = [
        {
          layout = "us";
        }
        {
          layout = "il";
        }
      ];
    };

    session.general.askForConfirmationOnLogout = false;
    session.sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";

    configFile = {
      kdeglobals.KDE.DndBehavior = "MoveIfSameDevice";
      klipperrc.General.KeepClipboardContents = false;

      spectaclerc.General = {
        closeAfterOcr = true;
        ocrLanguages = "eng";
      };
      "dolphinrc" = {
        General = {
          "ShowFullPath" = true;
        };
      };
    };

    dataFile = {
      "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" = true;
    };
  };
}
