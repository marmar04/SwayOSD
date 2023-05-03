# default.nix
{
  lib,
  glib,
  makeWrapper,
  rustPlatform,
  atk,
  gtk3,
  libpulseaudio,
  gtk-layer-shell,
  pkg-config,
  librsvg,
  rustfmt,
  cargo,
  rustc,
}: let
  cargoToml = builtins.fromTOML (builtins.readFile ./Cargo.toml);
in
  rustPlatform.buildRustPackage {
    src = ./.;

    buildInputs = [
      pkg-config
      glib
      atk
      gtk3
      librsvg
      gtk-layer-shell
      libpulseaudio
    ];

    cargoLock = {
      lockFile = ./Cargo.lock;
      /*
      outputHashes = {
        "kidex-common-0.1.0" = "sha256-sPzCTK0gdIYkKWxrtoPJ/F2zrG2ZKHOSmANW2g00fSQ=";
      };
      */
    };

    checkInputs = [cargo rustc];

    nativeBuildInputs = [
      pkg-config
      makeWrapper
      rustfmt
      rustc
      cargo
    ];

    doCheck = true;
    CARGO_BUILD_INCREMENTAL = "false";
    RUST_BACKTRACE = "full";
    copyLibs = true;

    name = cargoToml.package.name;
    version = cargoToml.package.version;

    /*
    postInstall = ''
      wrapProgram $out/bin/anyrun
    '';
    */

    meta = with lib; {
      description = "A OSD window for common actions like volume and capslock.";
      homepage = "https://github.com/ErikReider/SwayOSD";
      license = with licenses; [gpl3];
      /*
      maintainers = [
        {
          email = "";
          github = "";
          githubId = ;
          name = "";
        }
      ];
      */
    };
  }
