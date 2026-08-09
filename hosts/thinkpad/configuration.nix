{ pkgs, username, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/core/kde.nix
    ../../modules/core/sddm.nix
  ];

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };
}
