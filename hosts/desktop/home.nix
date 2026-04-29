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
     ../../modules/home/gemini.nix
  ];

  home.packages = with pkgs; [
    vlc
    telegram-desktop
    librewolf
    aria2
    uv
    ffmpeg-full
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
