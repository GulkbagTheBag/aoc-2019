let
  moz_overlay = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  nixpkgs = import <nixpkgs> { overlays = [ moz_overlay ]; };
in
  with nixpkgs;
  stdenv.mkDerivation rec {
    name = "rust_shell";
    buildInputs = [
      nixpkgs.latest.rustChannels.nightly.rust
      nixpkgs.rustup
    ];

    LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
  }
