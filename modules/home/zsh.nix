{ ... }:

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
      ls = "ls -lh --color=auto";
      grep = "grep -i --color=auto";
      tldr = ''() { curl "cheat.sh/$1"; }'';
      python = "python3";
    };
    initContent = ''
      if [[ -f ~/.extra_history ]]; then
          fc -R ~/.extra_history 2> /dev/null
      fi
    '';
  };

  home.file.".extra_history".text = ''
    sudo nixos-rebuild switch --flake ~/nixos-config
    sudo nixos-rebuild boot --flake ~/nixos-config
    sudo nixos-rebuild test --flake ~/nixos-config
    nix flake update --flake ~/nixos-config
    nixos-rebuild list-generations
    sudo rm /nix/var/nix/gcroots/auto/*; sudo nix-collect-garbage -d
    NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#anydesk
    nix run nixpkgs#hello -- --help
    nix shell nixpkgs#exfatprogs
    docker container prune -f;docker volume prune -f
    docker system prune -a
    docker run -it --rm debian:stable-slim /bin/bash
    if [ -d ".venv" ]; then source .venv/bin/activate; else python -m venv .venv; fi
    aria2c -x 16 -s 16
    rsync -avh src dst # sync folder preserve all file attributes
    ps aux
    pgrep -ai code # grep procs by name
    pkill -9 -i code
    du -h --max-depth=1 .
    grep -Rni --exclude-dir={node_modules,.git} "PATTERN" . # recursive text search
    find . -maxdepth 2 -iname "*tmp*" -exec rm -rf {} \;
    sudo ss -tulpn # tcp/udp listening
    tar -czvf archive.tgz folder/ names.txt
    tar -xzvf archive.tgz
    zip -r archive.zip folder/ names.txt
    sudo systemctl list-unit-files
    journalctl -u NetworkManager --since "today"
    systemctl --user list-unit-files
    journalctl --user --since "today"
  '';

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
