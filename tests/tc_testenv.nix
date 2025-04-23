rec {
  flake = builtins.getFlake "path:/home/sieyes/baghdad_plane/flakes/newEnv/";
  inputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    lighthouseAlexandria = builtins.getFlake "path:/home/sieyes/baghdad_plane/flakes/lighthouseAlexandria";
    nixvimFlakeInput = builtins.getFlake "github:nix-community/nixvim";
    colossusRhodes = builtins.getFlake "path:/home/sieyes/baghdad_plane/flakes/colossusRhodes";
  };
  pkgs = import inputs.nixpkgs {};
    libs = {
    baselib = inputs.lighthouseAlexandria.baselib;
    pkgslib = inputs.lighthouseAlexandria.pkgslib;
    typechecklib = inputs.colossusRhodes.typechecklib { typesSource = /home/sieyes/baghdad_plane/flakes/newEnv/mauso_halicarnassus; };
  };
    baseImport = import /home/sieyes/baghdad_plane/flakes/newEnv/temple_artemis_ephesus/montezuma_circles_scroll/envAttrs/base.nix;
  mkNixvimInput = baseImport // {
    inherit pkgs;
    makerFunc = inputs.nixvimFlakeInput.legacyPackages."x86_64-linux".makeNixvimWithModule;
    inherit libs;
  };
  mkNixvim = libs.baselib.mkNixvim;
  x = /home/sieyes/baghdad_plane/flakes/newEnv/temple_artemis_ephesus/montezuma_circles_scroll;
  singleImport = import (x + /resources/plugins/cmp.nix) { inherit libs; };
}
