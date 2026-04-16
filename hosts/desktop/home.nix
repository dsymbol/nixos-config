{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/home
    ../../modules/home/plasma.nix
  ];

  home.packages = with pkgs; [
    vlc
    telegram-desktop
    librewolf
    aria2
    kdePackages.krdc # rdp/vnc
    uv
    ffmpeg-full
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
