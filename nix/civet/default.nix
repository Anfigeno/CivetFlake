{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.default = pkgs.callPackage ./paquete { };
    };
}
