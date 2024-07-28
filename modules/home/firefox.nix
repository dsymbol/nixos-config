{ inputs, lib, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;
      extraConfig = lib.strings.concatStrings [
        (builtins.readFile "${inputs.arkenfox-userjs}/user.js")
        ''
          // disable data clearing
          user_pref("privacy.sanitize.sanitizeOnShutdown", false);
          // enable live search suggestions
          user_pref("browser.search.suggest.enabled", true);
          user_pref("browser.urlbar.suggest.searches", true);
        ''
      ];
    };
  };
}
