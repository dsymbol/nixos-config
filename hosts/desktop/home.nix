{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./../../modules/home
  ];

  home.packages = with pkgs; [
    vlc
    telegram-desktop
    librewolf
  ];
}
