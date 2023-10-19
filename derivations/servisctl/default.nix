{ lib, stdenv, fetchurl, autoPatchelfHook }:
stdenv.mkDerivation {
  name = "servisctl";
  version = "0.0.1";

  src = fetchurl {
    url = "https://tools.vseth.ethz.ch/servisctl/linux-amd64/servisctl";
    sha256 = "sha256-D9rpXiaAvzjvvyd/XGGqFVhC5rdNv4YcAUmeco10XQk=";
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
    
    install -Dm755 $src "$out/bin/servisctl"
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "Servis is the VIS specific microservice registry.";
    homepage = "https://documentation.vis.ethz.ch/servis.html";
    platforms = platforms.linux;
    maintainers = [ maintainers.markbeep ];
  };

}
