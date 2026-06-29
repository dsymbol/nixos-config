{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    libreoffice-qt6-still
    hunspell
    hunspellDicts.en_US-large
    hunspellDicts.he_IL
  ];
}
