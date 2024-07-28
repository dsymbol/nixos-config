{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.git;
    settings = {
      user.name = "dsymbol";
      user.email = "dsymbol@users.noreply.github.com";
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
    };
  };
}
