{ pkgs, host, ... }:

{
  imports = [
    ./noctalia.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    xwayland-satellite
    nautilus # gnome files
    noctalia-shell
    qimgv # image viewer
    playerctl # media control
    mousepad # notepad
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
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
      mouse-bindings = {
        primary-paste = "BTN_RIGHT";
        select-extend = "none";
      };
    };
  };

  xdg.configFile."niri/config.kdl".text = ''
    prefer-no-csd
    spawn-at-startup "noctalia-shell"
    screenshot-path null
    
    environment {
        QT_QPA_PLATFORM "wayland"
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
        match app-id=r#"firefox|codium"# 
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
        Mod+D { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
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

        ${
          if host == "desktop" then
            ''
              Mod+F12 { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
              Mod+F9  { spawn "playerctl" "-a" "play-pause"; }
              Mod+F11 { spawn "playerctl" "-a" "next"; }
              Mod+F10 { spawn "playerctl" "-a" "previous"; }
            ''
          else
            ""
        }
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

    cursor {
        xcursor-theme "Bibata-Modern-Ice"
        xcursor-size 24
    }

    hotkey-overlay {
        skip-at-startup
    }

    debug {
        honor-xdg-activation-with-invalid-serial
    }
  '';
}
