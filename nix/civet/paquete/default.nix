{ buildNpmPackage, lib, ... }:
buildNpmPackage {
  pname = "civet";
  version = "0.11.14";

  src = ./.;

  npmDepsHash = "sha256-/tT1iMvamE2Q6BYOTZKxU4Pb3sYdr86A0GTEZeI6ESQ=";

  dontNpmBuild = true;

  installPhase = /* sh */ ''
    runHook preInstall

    mkdir -p $out/lib/node_modules/civet $out/bin
    cp -r node_modules/. $out/lib/node_modules/civet/

    for bin in civet civet-lsp tsc tsserver; do
      ln -s "$out/lib/node_modules/civet/.bin/$bin" "$out/bin/$bin"
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Compilador Civet (civet), Civet Language Server (civet-lsp) y TypeScript (tsc)";
    homepage = "https://civet.dev";
    changelog = "https://github.com/DanielXMoore/Civet/blob/main/CHANGELOG.md";
    license = licenses.mit;
    mainProgram = "civet";
    platforms = platforms.all;
  };
}
