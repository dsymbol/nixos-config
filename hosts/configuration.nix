{
  pkgs,
  lib,
  username,
  host,
  ...
}:

{
  # User configuration
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "changeme";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };

  programs.zsh.enable =  true;
  
  time.timeZone = "Asia/Jerusalem";
  i18n.defaultLocale = "en_US.UTF-8";

  # UEFI
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      # useOSProber = true;
    };
  };

  # Enable nix flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.enable = lib.mkDefault true;
    useDHCP = lib.mkDefault true;
  };

  # System wide packages
  environment.systemPackages = with pkgs; [
    firefox
    vim
    nano
    python3
    git
    wget
    curl
    zip
    unzip
    htop
    nixd
    nixfmt
  ];

  virtualisation.docker.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  system.stateVersion = "22.11";
}
