{ ... }:

{
  programs.plasma.panels = [
    {
      location = "bottom";
      height = 46;
      floating = true;
      widgets = [
        # https://github.com/nix-community/plasma-manager/tree/trunk/modules/widgets
        # cat ~/.config/plasma-org.kde.plasma.desktop-appletsrc
        {
          kickoff = {
            icon = "nix-snowflake";
          };
        }
        "org.kde.plasma.marginsseparator"
        "org.kde.plasma.pager"
        "org.kde.plasma.windowlist"
        "org.kde.plasma.panelspacer"
        {
          iconTasks = {
            launchers = [
              "preferred://filemanager"
              "preferred://browser"
              "applications:org.kde.konsole.desktop"
              "applications:org.kde.kwrite.desktop"
              "applications:codium.desktop"
              "applications:systemsettings.desktop"
              "applications:virtualbox.desktop"
              "applications:librewolf.desktop"
              "applications:org.kde.plasma-systemmonitor.desktop"
              "applications:org.kde.kcalc.desktop"
            ];
            behavior.grouping = {
              method = "none";
              clickAction = "showTooltips";
            };
          };
        }
        "org.kde.plasma.panelspacer"
        {
          systemTray.items = {
            shown = [
              "org.kde.plasma.keyboardlayout"
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.volume"
            ];
          };
        }
        {
          digitalClock = {
            date.enable = false;
            time.format = "24h";
            font = {
              size = 13;
              family = "Noto Sans";
              bold = false;
              weight = 400;
            };
          };
        }
        "org.kde.plasma.minimizeall"
      ];
    }
  ];
}
