{ ... }:

{
  networking = {
    nameservers = [ "127.0.0.1" "::1" ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy = {
    enable = true;

    settings = {
      ipv4_servers = true;
      server_names = [ "controld-block-malware-ad" ];
    };
  };
}
