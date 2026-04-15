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
  ];
}
