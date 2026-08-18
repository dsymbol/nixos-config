{
  pkgs,
  host,
  config,
  ...
}:

{
  imports = [
    ./noctalia.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    xwayland-satellite
    nautilus # gnome files
    file-roller
    qimgv # image viewer
    playerctl # media control
    unstable.noctalia
  ];

  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
    };
    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        pad = "12x12";
        dpi-aware = "yes";
        selection-target = "both";
      };
    };
  };

  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    colorScheme = "dark";

    gtk4.theme = config.gtk.theme;
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  xdg.configFile."niri/config.kdl".text = ''
    prefer-no-csd
    spawn-at-startup "noctalia"
    screenshot-path null

    environment {
        QT_QPA_PLATFORM "wayland"
        QT_QPA_PLATFORMTHEME "gtk3"
        ELECTRON_OZONE_PLATFORM_HINT "auto"
        MOZ_ENABLE_WAYLAND "1"

        ${
          if host == "desktop" then
            ''
              GBM_BACKEND "nvidia-drm"
              __GLX_VENDOR_LIBRARY_NAME "nvidia"
              LIBVA_DRIVER_NAME "nvidia"
            ''
          else
            ""
        }
    }

    input {
        keyboard {
            xkb {
                layout "us,il"
                options "grp:alt_shift_toggle"
            }
            numlock
        }

        touchpad {
            tap
            natural-scroll
        }

        mouse {
            accel-speed 0.0 
            accel-profile "flat"
        }
    }

    // niri msg outputs
    ${
      if host == "desktop" then
        ''
          output "DP-3" {
              mode "1920x1080@144.001"
              scale 1
              transform "normal"
              position x=0 y=0
          }
        ''
      else
        ""
    }

    window-rule {
        match app-id=r#"brave|librewolf|codium|libreoffice|VirtualBoxVM"# 
        default-column-width { proportion 1.0; }
        open-maximized false
    }

    window-rule {
        match app-id=r#"foot"#
        opacity 0.98
    }

    binds {
        Mod+F1 { show-hotkey-overlay; }
        Mod+T { spawn "foot"; }
        Mod+D { spawn-sh "noctalia msg panel-toggle launcher"; }
        Mod+V { spawn-sh "noctalia msg panel-toggle clipboard"; }
        Mod+Q repeat=false { close-window; }
        Mod+E { quit; }

        Print { screenshot; }
        Mod+Space repeat=false { toggle-overview; }

        Mod+Left  { focus-column-left; }
        Mod+Right { focus-column-right; }
        Mod+WheelScrollDown { focus-column-right; }
        Mod+WheelScrollUp   { focus-column-left; }
        Mod+Down  { focus-window-down; }
        Mod+Up    { focus-window-up; }
        Mod+Ctrl+Left  { move-column-left; }
        Mod+Ctrl+Right { move-column-right; }

        Mod+W { switch-preset-column-width; }
        Mod+M { maximize-column; }

        F9  { spawn "playerctl" "-a" "play-pause"; }
        F11 { spawn "playerctl" "-a" "next"; }
        F10 { spawn "playerctl" "-a" "previous"; }
        F12 { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    }

    layout {
        gaps 10

        center-focused-column "never"
        always-center-single-column

        preset-column-widths {
            proportion 0.5
            proportion 0.8
            proportion 1.0
        }

        default-column-width { proportion 0.5; }

        border {
            width 3
            active-color "#cba6f7"
            inactive-color "#45475a"
            urgent-color "#9b0000"
        }

        focus-ring {
            off
        }

        shadow {
            softness 30
            spread 5
            offset x=0 y=5
            color "#0007"
        }

        struts {
        }
    }

    window-rule {
        geometry-corner-radius 10
        clip-to-geometry true
        draw-border-with-background false
    }

    hotkey-overlay {
        skip-at-startup
    }

    debug {
        honor-xdg-activation-with-invalid-serial
    }
  '';
}
