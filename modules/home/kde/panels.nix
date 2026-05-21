{ ... }:

{
  programs.plasma.panels = [
    {
      location = "bottom";
      height = 42;
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
              "applications:org.kde.konsole.desktop"
              "applications:org.kde.kwrite.desktop"
              "applications:codium.desktop"
              "applications:virtualbox.desktop"
              "applications:librewolf.desktop"
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
              "org.kde.plasma.keyboardlayout"
              "org.kde.plasma.networkmanagement"
              "org.kde.plasma.volume"
            ];
            hidden = [
              "org.kde.plasma.clipboard"
              "org.kde.plasma.brightness"
            ];
            configs = {
              battery.showPercentage = true;
              keyboardLayout.displayStyle = "flag";
            };
          };
        }
        {
          digitalClock = {
            date.enable = false;
            time.format = "24h";
          };
        }
        "org.kde.plasma.minimizeall"
      ];
    }
  ];
}
