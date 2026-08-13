{
  ...
}:

{
  programs.plasma.shortcuts = { # nix run github:nix-community/plasma-manager
    "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Shift";
    "mediacontrol"."playpausemedia" = [ "Media Play" "F9" ];
    "mediacontrol"."previousmedia" = [ "Media Previous" "F10" ];
    "mediacontrol"."nextmedia" = [ "Media Next" "F11" ];
    "kmix"."mute" = [ "Volume Mute" "F12" ];
    kwin."Kill Window" = "Meta+Q";
    kwin."Walk Through Windows" = [ "Alt+Tab" ];
    plasmashell.show-on-mouse-pos = "Meta+V";
    plasmashell."activate application launcher" = [ "Meta" ];
    kwin.view_actual_size = "Meta+0";
    kwin.view_zoom_out = "Meta+-";
    kwin.view_zoom_in = ["Meta++" "Meta+="];

    org_kde_powerdevil.powerProfile = [ "Battery" ];
    "KDE Keyboard Layout Switcher"."Switch to Last-Used Keyboard Layout" = [ ];
    kaccess."Toggle Screen Reader On and Off" = [ ];
    ksmserver."Lock Session" = [ ];
    kwin."Activate Window Demanding Attention" = [ ];
    kwin."Edit Tiles" = [ ];
    kwin.ExposeAll = [ ]; 
    kwin.ExposeClass = [ ];
    kwin."Grid View" = [ ];
    kwin.MoveMouseToCenter = [ ];
    kwin.MoveMouseToFocus = [ ];
    kwin."Switch One Desktop Down" = [ ];
    kwin."Switch One Desktop Up" = [ ];
    kwin."Switch One Desktop to the Left" = [ ];
    kwin."Switch One Desktop to the Right" = [ ];
    kwin."Switch Window Down" = [ ];
    kwin."Switch Window Left" = [ ];
    kwin."Switch Window Right" = [ ];
    kwin."Switch Window Up" = [ ];
    kwin."Switch to Desktop 1" = [ ];
    kwin."Switch to Desktop 2" = [ ];
    kwin."Switch to Desktop 3" = [ ];
    kwin."Switch to Desktop 4" = [ ];
    kwin."Walk Through Windows (Reverse)" = [ ];
    kwin."Walk Through Windows of Current Application" = [ ];
    kwin."Walk Through Windows of Current Application (Reverse)" = [ ];
    kwin."Window Maximize" = [ ];
    kwin."Window Minimize" = [ ];
    kwin."Window One Desktop Down" = [ ];
    kwin."Window One Desktop Up" = [ ];
    kwin."Window One Desktop to the Left" = [ ];
    kwin."Window One Desktop to the Right" = [ ];
    kwin."Window Operations Menu" = [ ];
    kwin."Window to Next Screen" = [ ];
    kwin."Window to Previous Screen" = [ ];
    kwin.disableInputCapture = [ ];
    plasmashell."activate task manager entry 1" = [ ];
    plasmashell."activate task manager entry 2" = [ ];
    plasmashell."activate task manager entry 3" = [ ];
    plasmashell."activate task manager entry 4" = [ ];
    plasmashell."activate task manager entry 5" = [ ];
    plasmashell."activate task manager entry 6" = [ ];
    plasmashell."activate task manager entry 7" = [ ];
    plasmashell."activate task manager entry 8" = [ ];
    plasmashell."activate task manager entry 9" = [ ];
    plasmashell.clipboard_action = [ ];
    plasmashell.cycle-panels = [ ];
    plasmashell."manage activities" = [ ];
    plasmashell."show dashboard" = [ ];
  };
}
