{ lib, stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation {
  name = "sipctl";

  src = fetchurl {
    url = "https://tools.vseth.ethz.ch/sipctl/linux-amd64/sipctl";
    sha256 = "e8cf4452365afbde09c64605a42266eb3451168188d9968b0eaa11a22e3b1459";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

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
