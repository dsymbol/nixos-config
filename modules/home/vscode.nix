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
