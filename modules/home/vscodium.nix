{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixd
    nixfmt
  ];

  programs.vscodium = {
    enable = true;
    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          jnoortheen.nix-ide
          ms-python.python
          charliermarsh.ruff
          arrterian.nix-env-selector
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "ty";
            publisher = "astral-sh";
            version = "2026.44.0";
            sha256 = "sha256-0D/ZGHSDxtUfuQEL9C8ID/UZo7OPoT948tgKFBE3Hyw=";
          }
        ];
      userSettings = {
        "files.autoSave" = "afterDelay";
        "editor.formatOnSave" = true;
        "explorer.confirmDelete" = false;
        "telemetry.telemetryLevel" = "off";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "workbench.editor.enablePreview" = false;

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
