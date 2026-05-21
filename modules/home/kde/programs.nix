{
  ...
}:

{
  programs.konsole = {
    enable = true;
    defaultProfile = "main";

    profiles.main = {
      font = {
        name = "Hack";
        size = 10.5;
      };
      extraConfig = {
        General.TerminalMargin = 8;
        Scrolling.HistoryMode = 2;
        "Terminal Features".BlinkingCursorEnabled = true;
        "Interaction Options" = {
          AutoCopySelectedText = true;
          CopyTextAsHTML = false;
          TrimLeadingSpacesInSelectedText = true;
          TrimTrailingSpacesInSelectedText = true;
          MiddleClickPasteMode = 1;
        };
      };
    };
  };

  programs.plasma.spectacle.shortcuts = {
    captureActiveWindow = null;
    captureCurrentMonitor = null;
    captureEntireDesktop = null;
    captureRectangularRegion = "Print";
    captureWindowUnderCursor = null;
    launch = null;
    launchWithoutCapturing = null;
    recordRegion = null;
    recordScreen = null;
    recordWindow = null;
  };
}
