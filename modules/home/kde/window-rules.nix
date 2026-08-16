{ ... }:

let
  matchClass = class: {
    window-class = {
      value = class;
      type = "regex";
      match-whole = false;
    };
  };

  matchTitle = title: {
    title = {
      value = title;
      type = "regex";
    };
  };

  opacity = val: {
    opacityactive = {
      value = val;
      apply = "force";
    };
    opacityinactive = {
      value = val;
      apply = "force";
    };
  };

  maximize = state: {
    maximizehoriz = {
      value = state;
      apply = "initially";
    };
    maximizevert = {
      value = state;
      apply = "initially";
    };
  };

  size =
    val:
    {
      size = {
        value = val;
        apply = "initially";
      };
    }
    // (maximize false);
in
{
  programs.plasma.window-rules = [
    {
      description = "konsole";
      match = matchClass "konsole";
      apply = (opacity 98) // (size "950,500");
    }
    # {
    #   description = "dolphin";
    #   match = matchClass "dolphin";
    #   apply = (opacity 98) // (size "910,710");
    # }
    # {
    #   description = "systemsettings";
    #   match = (matchClass "systemsettings");
    #   apply = (size "980,790");
    # }
    {
      description = "Start maximized";
      match =
        (matchClass "brave|codium|librewolf") // (matchTitle "(Brave Origin|LibreWolf|Codium)$");
      apply = maximize true;
    }
  ];
}
