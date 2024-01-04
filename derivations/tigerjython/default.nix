{ lib, stdenv, pkgs, fetchurl }:
stdenv.mkDerivation {
  name = "tigerjython";
  version = "2.38";

  src = fetchurl {
    url = "https://www.tigerjython.ch/user/pages/download/tigerjython2.jar";
    sha256 = "sha256-aBsoPeFgzWVKKunRrj5dhdx0YxReQvS8HcseIbHKQlE=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  propagatedBuildInputs = [ pkgs.openjdk11-bootstrap ];

  installPhase = ''
    runHook preInstall

    echo "#!/bin/sh" > tj
    echo "${pkgs.openjdk11-bootstrap}/bin/java -jar $out/tj.jar" >> tj
    install -Dm755 tj $out/bin/tigerjython
    cp $src $out/tj.jar

    runHook postInstall
  '';

  meta = with lib; {
    description = "";
    homepage = "https://www.tigerjython.ch/";
    platforms = platforms.linux;
    maintainers = [ maintainers.markbeep ];
  };

}
