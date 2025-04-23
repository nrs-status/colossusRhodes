{}:
{
  name = "nonEmptyAttrs";
  function = attrs:
    0 < builtins.length (builtins.attrNames attrs);
  failureMsg = "attribute set is empty";
}
