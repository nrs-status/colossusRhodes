{ libs }:
{ type, typeName, target, activateDebug ? false }:
let total = rec {
  expectedFields = type.fields;
  targetFields = builtins.attrNames target;
  functionToMap = key: {
    isInExpectedFields = builtins.elem key expectedFields;
    key = key;
  };
  mapping = builtins.map functionToMap targetFields;
  filterToApply = pair: pair.isInExpectedFields == false;
  filtering = builtins.filter filterToApply mapping;
  mainCondition = (builtins.length filtering == 0) || (builtins.length expectedFields == 0);
  final = if mainCondition then
    target
  else
      throw ("typecheckFields.nix: failure to typecheck " + typeName + "; the following fields are missing: " + (builtins.toString filtering)); };
in libs.baselib.withDebug activateDebug {
    debug = total;
    nondebug = total.final;
}
