{ nixpkgs ? import <nixpkgs> {} }:

let
  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;

  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

  haskellDeps = ps: with ps; [
    base
    megaparsec
    hspec-megaparsec
    Unique
  ];

  ghc = haskellPackages.ghcWithPackages haskellDeps;

  nixPackages = [
    (all-hies.selection { selector = p: { inherit (p) ghc864; }; })
    ghc
    haskellPackages.hlint
    haskellPackages.hindent
    haskellPackages.ghcid
    haskellPackages.hdevtools
    haskellPackages.hoogle
    pkgs.gdb
    pkgs.stack
    haskellPackages.cabal-install
  ];
in
  pkgs.stdenv.mkDerivation {
    name = "env";
    buildInputs = nixPackages;
  }
