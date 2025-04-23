{ libs, typesSource }:
{
  typecheck = import ./typecheck.nix { inherit libs; inherit typesSource; };
  predicates = libs.baselib.importPairAttrsOfDir {
    filePath = ./predicates;
    inputForImportPairs = {};
  };
  tc = import ./tc.nix { inherit libs; inherit typesSource; };
}
