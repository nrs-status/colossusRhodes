{ libs, typesSource }:
{ typeName, total, activateDebug ? false, }:
let 
  typecheck = import ./typecheck.nix { inherit libs; inherit typesSource; };
  typecheckResult = typecheck {
    inherit typeName;
    target = total.final;
  };
in libs.baselib.withDebug activateDebug {
    debug = {
      inherit total;
      inherit typecheckResult;
    };
    nondebug = typecheckResult;
}
