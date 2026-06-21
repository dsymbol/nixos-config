{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      id = 0;
      name = "Default";
      isDefault = true;

      search = {
        default = "ddg";
        privateDefault = "ddg";

        order = [
          "ddg"
          "google"
          "Nix Packages"
        ];

        engines = {
          "google" = {
            name = "Google";
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "@g" ];
          };

          "Nix Packages" = {
            name = "Nix Packages";
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
        };
      };

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
