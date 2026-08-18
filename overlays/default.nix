{ inputs, ... }: {
  additions = final: _prev: {
    additions = import ../pkgs final.pkgs;
  };

  unstable = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
