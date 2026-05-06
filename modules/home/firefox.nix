{ inputs, lib, config, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
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
