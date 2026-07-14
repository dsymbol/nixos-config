{ pkgs, ... }:

{
  imports = [
    ./greetd.nix
  ];

  security.pam.services.greetd.kwallet.enable = true;
  
  services = {
    displayManager.sddm.enable = false;
    desktopManager.plasma6.enable = true;
  };

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
}
