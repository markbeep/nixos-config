{ lib, stdenv, fetchurl, autoPatchelfHook }:
let
  # downloads the checksum from the given url
  getChecksum = url: with builtins;
    lib.pipe (builtins.fetchurl url) [
      readFile
      (split " ")
      head
    ];
in
stdenv.mkDerivation {
  name = "sipctl";
  version = "0.0.1";

  # luckily these urls stay consistent
  src = fetchurl {
    url = "https://tools.vseth.ethz.ch/sipctl/linux-amd64/sipctl";
    sha256 = "sha256-jbP8XpjXYa5i+UUFVgkDkQ4bG42CL8q67E20u81pkHs=";
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
    
    install -Dm755 $src $out/bin/sipctl
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "This is a command-line tool to interact with SIP.\
    It is meant to support the same tasks as Gatekeeper.";
    homepage = "https://wiki.vseth.ethz.ch/display/0403DE/SIP";
    platforms = platforms.linux;
    maintainers = [ maintainers.markbeep ];
  };

}
