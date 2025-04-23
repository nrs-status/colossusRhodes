{
  description = "A very basic flake";

  inputs = {
    lighthouseAlexandria.url = "path:/home/sieyes/baghdad_plane/flakes/lighthouseAlexandria";
  };

  outputs = inputs: let
    libs = {
      baselib = inputs.lighthouseAlexandria.baselib;
      pkgslib = inputs.lighthouseAlexandria.pkgslib;
    }; in {
    typechecklib = { typesSource }: import ./typechecklib { inherit libs; inherit typesSource; };
  };
}
