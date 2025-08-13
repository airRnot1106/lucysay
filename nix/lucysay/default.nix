{
  buildGleamApplication,
  stdenv,
  bun,
  platform,
}:
let
  pname = "lucysay";
  version = "0.1.1";

  targets = {
    x86_64-linux = "bun-linux-x64";
    aarch64-linux = "bun-linux-arm64";
    x86_64-darwin = "bun-darwin-x64";
    aarch64-darwin = "bun-darwin-arm64";
  };

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
    export BUN_INSTALL_CACHE_DIR=$TMPDIR/bun-cache
    mkdir -p $BUN_INSTALL_CACHE_DIR
    bun build --compile --minify --target ${targets.${platform}} --outfile=lucysay $src/lib/lucysay/main.mjs
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 lucysay -t $out/bin
    runHook postInstall
  '';
}
