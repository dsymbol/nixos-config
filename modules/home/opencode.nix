{
  pkgs,
  inputs,
  ...
}:

let
  jail = inputs.jail-nix.lib.init pkgs;

  commonPkgs = with pkgs; [
    bashInteractive
    jq
    git
    which
    ripgrep
    gnugrep
    gawkInteractive
    ps
    findutils
    gzip
    unzip
    gnutar
    diffutils
    gnused
    curl
    wget
  ];
in
{
  home.packages = [
    (jail "opencode" pkgs.unstable.opencode (
      with jail.combinators; # https://alexdav.id/projects/jail-nix/combinators/
      [
        network
        no-new-session
        time-zone

        (persist-home "opencode")
        mount-cwd

        (add-pkg-deps (
          commonPkgs
          ++ [
            pkgs.python3
            pkgs.nodejs
          ]
        ))
      ]
    ))
  ];
}
