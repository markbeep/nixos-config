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
    sha256 = getChecksum "https://tools.vseth.ethz.ch/sipctl/linux-amd64/sipctl.checksum";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  # required for binary to be executable
  nativeBuildInputs = [
    autoPatchelfHook
  ];

  installPhase = ''
    mkdir -p "$out/bin"
    cp $src "$out/bin/sipctl"
    chmod +x $out/bin/sipctl
  '';

  meta = with lib; {
    description = "This is a command-line tool to interact with SIP.\
    It is meant to support the same tasks as Gatekeeper.";
    homepage = "https://wiki.vseth.ethz.ch/display/0403DE/SIP";
    platforms = platforms.linux;
    maintainers = [ maintainers.mark ];
  };

}
