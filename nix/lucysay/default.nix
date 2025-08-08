{
  buildGleamApplication,
  stdenv,
  bun,
}:
let
  pname = "lucysay";
  version = "0.1.0";

  nix-gleam = buildGleamApplication {
    inherit pname version;

    src = ../..;

    target = "javascript";
  };
in
stdenv.mkDerivation {
  inherit pname version;

  src = nix-gleam.out;

  nativeBuildInputs = [
    bun
  ];

  buildPhase = ''
    runHook preBuild
    bun build --compile --minify --outfile=lucysay $src/lib/lucysay/main.mjs
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 lucysay -t $out/bin
    runHook postInstall
  '';

  checkPhase = ''
    runHook preCheck
    $out/bin/lucysay --version
    runHook postCheck
  '';
}
