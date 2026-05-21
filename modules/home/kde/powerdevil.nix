{
  ...
}:

let
  seconds = sec: sec;
  minutes = min: min * 60;
in
{
  programs.plasma.powerdevil = {
    general.pausePlayersOnSuspend = true;

    batteryLevels = {
      lowLevel = 10;
      criticalLevel = 5;
      criticalAction = "hibernate";
    };

    AC = {
      powerProfile = "performance";
      powerButtonAction = "sleep";
      autoSuspend = {
        idleTimeout = minutes 30;
        action = "sleep";
      };
      displayBrightness = 80;
      dimDisplay = {
        enable = true;
        idleTimeout = minutes 30;
      };
      turnOffDisplay.idleTimeout = minutes 10;
    };

    battery = {
      powerProfile = "balanced";
      powerButtonAction = "sleep";
      autoSuspend = {
        idleTimeout = minutes 5;
        action = "sleep";
      };
      displayBrightness = 60;
      dimDisplay = {
        enable = true;
        idleTimeout = minutes 2;
      };
      turnOffDisplay.idleTimeout = minutes 3;
    };

    lowBattery = {
      powerProfile = "powerSaving";
      powerButtonAction = "sleep";
      autoSuspend = {
        idleTimeout = minutes 2;
        action = "sleep";
      };
      displayBrightness = 30;
      dimDisplay = {
        enable = true;
        idleTimeout = seconds 30;
      };
      turnOffDisplay.idleTimeout = minutes 1;
    };
  };
}
