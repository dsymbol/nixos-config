{
  lib,
  host,
  ...
}:

{
  networking = {
    hostName = host;
    networkmanager.enable = true;
    firewall.enable = lib.mkDefault true;
    useDHCP = lib.mkDefault true;
  };

  services.resolved = {
    enable = true;
    settings.Resolve.LLMNR = false;
    settings.Resolve.MulticastDNS = false;
  };

  # fix slow loading
  networking.enableIPv6 = false;
  boot.kernelParams = [ "ipv6.disable=1" ];
}
