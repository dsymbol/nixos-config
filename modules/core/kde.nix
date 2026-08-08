{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    krdc
    kcalc
    kolourpaint
    krecorder

    # for `Text Extract` feature: requires compilation
    (spectacle.override { tesseractLanguages = [ "eng" ]; })
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    okular
    oxygen
    plasma-browser-integration
    kinfocenter
  ];

  # unlock kwallet
  security.pam.services.greetd.kwallet.enable = config.services.greetd.enable;
}
