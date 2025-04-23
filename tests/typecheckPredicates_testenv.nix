rec {
  flake = builtins.getFlake "path:/home/seba/newEnv/";
  inputs = {
    nixpkgs = builtins.getFlake "github:NixOs/nixpkgs/nixos-unstable";
    lighthouseAlexandria = builtins.getFlake "path:/home/seba/lighthouseAlexandria";
    nixvimFlakeInput = builtins.getFlake "github:nix-community/nixvim";
    colossusRhodes = builtins.getFlake "path:/home/seba/colossusRhodes";
  };
  pkgs = import inputs.nixpkgs {};
  libs = {
    baselib = inputs.lighthouseAlexandria.baselib;
    pkgslib = inputs.lighthouseAlexandria.pkgslib;
    typechecklib = inputs.colossusRhodes.typechecklib { typesSource = /home/seba/newEnv/mauso_halicarnassus; };
  };
  baseImport = import /home/seba/newEnv/temple_artemis_ephesus/montezuma_circles_scroll/envAttrs/base.nix;
  mkNixvimInput = baseImport // {
    inherit pkgs;
    makerFunc = inputs.nixvimFlakeInput.legacyPackages."x86_64-linux".makeNixvimWithModule;
    inherit libs;
  };
  mkNixvim = libs.baselib.mkNixvim;

  x = /home/seba/newEnv/temple_artemis_ephesus/montezuma_circles_scroll;
  predicates = libs.typechecklib.predicates;
  importedTypesSource = libs.baselib.importPairAttrsOfDir {
    filePath = /home/seba/newEnv/mauso_halicarnassus;
    inputForImportPairs = { inherit libs; };
  };
  predicatesOfType = (import ../typechecklib/constructPredicatesFromPredicateList.nix { inherit libs; }) importedTypesSource.types.SingleFieldAttrs.predicates;
  targetWithDebug = import (x + /resources/plugins/cmp.nix) {inherit libs; withDebug = true; };
  mapping = builtins.mapAttrs (field: val: val.function targetWithDebug.typechecked) predicatesOfType;
  filtering = libs.pkgslib.filterAttrs (field: val: val == false) mapping;
  singleImport = import (x + /resources/plugins/cmp.nix) { inherit libs; };
  importMapping = builtins.map (path: import path { inherit libs; }) baseImport.pluginsList;
  plugins = libs.baselib.concatAttrSets importMapping;
}
