{ lib, stdenv, fetchurl, autoPatchelfHook }:
stdenv.mkDerivation {
  name = "servis";
  version = "0.0.1";

  src = fetchurl {
    url = "https://ser.vis.ethz.ch/static/servis-cli-linux-amd64";
    sha256 = "sha256-k8wZo1G4A9HZrmkPhJTRtVrHDuFRPj3C6KExWL/ej1Y=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  # required for binary to be executable
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  installPhase = ''
    runHook preInstall
    
    mkdir -p "$out/bin"
    cp $src "$out/bin/servis"
    chmod +x $out/bin/servis
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Servis is the VIS specific microservice registry.";
    homepage = "https://documentation.vis.ethz.ch/servis.html";
    platforms = platforms.linux;
    maintainers = [ maintainers.markbeep ];
  };

}
