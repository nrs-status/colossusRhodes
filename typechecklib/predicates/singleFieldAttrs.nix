{}:
{
  name = "singleFieldAttrs";
  function = attrs:
    1 == builtins.length (builtins.attrNames attrs);
  failureMsg = "attribute set does not have exactly one field";
}
