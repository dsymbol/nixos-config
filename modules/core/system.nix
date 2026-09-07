{
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = builtins.attrValues (import ../../overlays { inherit inputs; });
  };

  nix = {
    optimise.automatic = true;

    registry.nixpkgs.flake = inputs.nixpkgs;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];

      # use local registry
      use-registries = true;
      flake-registry = "";
    };
  };

  environment.systemPackages = with pkgs; [
    lsof
    usbutils
    pciutils
    bind

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
