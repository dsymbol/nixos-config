{ pkgs, inputs, lib, user, ... }:

{
  imports = [
    ../../modules/gossa
  ];

  home = {
    stateVersion = "22.11";
    packages = with pkgs; [
      tldr
      ripgrep
      pfetch
      gossa
      fd
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
    username = user;
    homeDirectory = "/home/${user}";
  };

  services.gossa = {
    enable = true;
    directory = "/home/me/share";
    port = 80;
  };

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      shellAliases = {
        # misc
        ls = "ls -l --color=auto";
        # python
        python = "python3";
        venv = ''if [ -d "venv" ]; then source venv/bin/activate; else python -m venv venv; fi'';
        # nix
        napply = "sudo nixos-rebuild switch --flake ~/nixos-config";
        nupdate = "nix flake update ~/nixos-config --commit-lock-file";
        # docker 
        dshell = ''() { [ -z "$1" ] && set -- "ubuntu"; docker run -d -t --rm $1; docker exec -it $(docker container ls -q -n 1) /bin/sh; }'';
        dprune = ''docker system prune -a'';
      };
      initExtra = ''
        pfetch
      '';
      history = {
        ignoreDups = true;
        ignoreSpace = true;
      };
    };
  };

}
