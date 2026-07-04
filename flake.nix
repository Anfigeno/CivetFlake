{
  description = "Civet: compilador, language server y tsc, empaquetados desde npm";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [
        ./nix/civet
        ./nix/shellDeDesarrollo.nix
      ];

      flake.overlays.default = final: prev: {
        civet = prev.callPackage ./nix/civet/paquete { };
        vimPlugins = prev.vimPlugins // {
          nvim-treesitter-parsers = prev.vimPlugins.nvim-treesitter-parsers // {
            civet = final.callPackage ./nix/civet/paquete/gramaticaTreesitter.nix { };
          };
        };
      };
    };
}
