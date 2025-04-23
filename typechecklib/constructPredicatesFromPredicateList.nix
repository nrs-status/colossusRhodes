{ libs }:
predicateList:
  let predicatesLib = libs.baselib.importPairAttrsOfDir {
    filePath = ./predicates;
    inputForImportPairs = {};
  }; in
libs.pkgslib.filterAttrs (name: val: builtins.elem name predicateList) predicatesLib
