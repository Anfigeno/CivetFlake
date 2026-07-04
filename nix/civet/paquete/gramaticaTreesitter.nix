{
  stdenv,
  fetchFromGitHub,
  lib,
  ...
}:
let
  civetSrc = fetchFromGitHub {
    owner = "DanielXMoore";
    repo = "Civet";
    rev = "df3ed3d6e36c2f031e90554df084ffc2f359c92e";
    hash = "sha256-I4qCK1rGiR8okXn6ZFen7WrO6OJ0ckBWy4tb24T3e7o=";
  };

  mkTreeSitterGrammar =
    {
      name,
      subdir,
      symbol,
    }:
    stdenv.mkDerivation {
      pname = "tree-sitter-${name}";
      version = "0.0.1";
      src = civetSrc;
      dontConfigure = true;
      buildPhase = ''
        runHook preBuild
        cd "${subdir}"
        $CC -shared -fPIC -Isrc -o parser.so src/parser.c
        runHook postBuild
      '';
      installPhase = ''
        runHook preInstall
        mkdir -p $out/parser $out/queries/civet
        cp parser.so $out/parser/${name}.so
        cp -r queries/. $out/queries/civet
        runHook postInstall
      '';
      meta = with lib; {
        description = "Gramática tree-sitter (resaltado de sintaxis) para ${name}, símbolo ${symbol}";
        homepage = "https://github.com/DanielXMoore/Civet/tree/main/${subdir}";
        license = licenses.mit;
        platforms = platforms.all;
      };
    };
in
mkTreeSitterGrammar {
  name = "civet";
  subdir = "lsp/tree-sitter";
  symbol = "tree_sitter_civet";
}
