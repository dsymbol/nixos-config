{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/home
    ../../modules/home/kde.nix
    ../../modules/home/gemini.nix
  ];

  home.packages = with pkgs; [
    vlc
    telegram-desktop
    librewolf
    aria2
    ffmpeg-full
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
