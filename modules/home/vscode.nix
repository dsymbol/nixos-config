{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          jnoortheen.nix-ide
          ms-python.python
          charliermarsh.ruff
          mkhl.direnv
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "ty";
            publisher = "astral-sh";
            version = "2026.36.0";
            sha256 = "sha256-wFyIxOQHzsNur9wgE4Td8xSxuWq5nWhOlsZ0jm1fkEo=";
          }
        ];
      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.formatOnSave" = true;
        "explorer.confirmDelete" = false;
        "telemetry.telemetryLevel" = "off";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";

        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
          "editor.codeActionsOnSave" = {
            "source.organizeImports" = "explicit";
            "source.fixAll.ruff" = "explicit";
          };
        };
      };
    };
  };
}
