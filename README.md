# Civet para NixOS

Flake con las herramientas de [Civet](https://civet.dev) (`civet`, `civet-lsp` y `tsc`) usando `buildNpmPackage`.

## Uso

```bash
    # Probar sin instalar
    nix run . -- --help
    nix run .#civet -- source.civet

    # Shell temporal con civet, civet-lsp y tsc en el PATH
    nix develop
```
