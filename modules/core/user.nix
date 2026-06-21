{
  inputs,
  pkgs,
  username,
  host,
  pkgs-unstable,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = { inherit inputs username host pkgs-unstable; };
    users.${username} = {
      imports = [ ../../hosts/${host}/home.nix ];
      home = {
        stateVersion = "22.11";
        username = username;
        homeDirectory = "/home/${username}";
      };
      programs.home-manager.enable = true;
    };
    backupFileExtension = "bak";
    overwriteBackup = true;
  };
  
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "password";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
  
  programs.zsh.enable = true;
}
