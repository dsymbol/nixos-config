{
  lib,
  pkgs,
  username,
  ...
}:

{
  virtualisation = {
    containers = {
      enable = true;
      registries.search = [ "docker.io" ];
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.${username} = {
    extraGroups = [ "podman" ];
    linger = lib.mkDefault false;
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    podlet # generate quadlets
  ];
}
