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
}
