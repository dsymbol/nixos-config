{ pkgs, username, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "gentoo";
      plugins = [ "colored-man-pages" ];
    };

    shellAliases = {
      # misc
      ls = "ls -lh --color=auto";
      grep = "grep -i --color=auto";
      # python
      python = "python3";
      venv = ''if [ -d "venv" ]; then source venv/bin/activate; else python -m venv venv; fi'';
      # nix
      nswitch = "sudo nixos-rebuild switch --flake ~/nixos-config";
      ntest = "sudo nixos-rebuild test --flake ~/nixos-config";
      nupdate = "nix flake update ~/nixos-config";
      # docker
      dshell = ''() { [ -z "$1" ] && set -- "debian:stable-slim"; docker run -d -t --rm $1; docker exec -it $(docker container ls -q -n 1) /bin/sh; }'';
      dcprune = "docker container prune -f;docker volume prune -f";
      dprune = "docker system prune -a";
    };
    # initContent = ''

    # '';
  };
}
