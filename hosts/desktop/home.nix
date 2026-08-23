{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../../modules/home
    ../../modules/home/kde
    ../../modules/home/opencode.nix
  ];

  home.packages = with pkgs; [
    vlc
    telegram-desktop
    librewolf
    aria2
    ffmpeg-full
    wl-clipboard
    additions.ytdl
  ];
}
