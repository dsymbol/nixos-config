{
  pkgs,
  ...
}:

{
  nix = {
    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    usbutils
    lsof
    vim
    nano
    git
    wget
    curl
    zip
    unzip
  ];

  time.timeZone = "Asia/Jerusalem";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = "en_GB.UTF-8";
  
  system.stateVersion = "22.11";
}
