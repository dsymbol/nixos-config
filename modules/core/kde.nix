{ pkgs, ... }:

{
  services = {
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.krdc
    kdePackages.kcalc
    kdePackages.kolourpaint
  ];
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    okular
    oxygen
    plasma-browser-integration
    kinfocenter
  ];
}
