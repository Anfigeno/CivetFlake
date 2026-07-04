{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages = {
        default = pkgs.callPackage ./paquete { };
        civet = pkgs.callPackage ./paquete { };
        treesitter-civet = pkgs.callPackage ./paquete/gramaticaTreesitter.nix { };
      };
    };
}
