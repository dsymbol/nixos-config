{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  kdePackages,
  nix-update-script,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "wallhaven-plasma-potd";
  version = "2026.08.27";

  src = fetchFromGitHub {
    owner = "dsymbol";
    repo = "wallhaven-plasma-potd";
    tag = finalAttrs.version;
    hash = "sha256-FzgI6/P8aGqUTo+pCqM7CJjFnWw/5/jkUo8wo5EH9kE=";
  };

  nativeBuildInputs = [
    cmake
    kdePackages.extra-cmake-modules
  ];

  buildInputs = [
    kdePackages.kdeplasma-addons
    kdePackages.kio
  ];

  strictDeps = true;

  cmakeFlags = [
    (lib.cmakeFeature "Qt6_DIR" "${kdePackages.qtbase}/lib/cmake/Qt6")
  ];

  dontWrapQtApps = true;

  passthru.updateScript = nix-update-script { };
})
