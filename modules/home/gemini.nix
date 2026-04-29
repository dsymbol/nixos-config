{ ... }:

{
  programs.gemini-cli = {
    enable = true;
    settings = {
      ui = {
        hideBanner = true;
        showCitations = true;
        showModelInfoInChat = true;
        showStatusInTitle = true;
      };

      general.checkpointing.enabled = true;

      tools.confirmationRequired = [
        "web_fetch"
        "google_web_search"
        "run_shell_command"
      ];

      security = {
        disableYoloMode = true;
        auth.selectedType = "oauth-personal";
      };

      privacy.usageStatisticsEnabled = false;
    };
  };
}
