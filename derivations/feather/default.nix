{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "feather";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "AT-UI";
    repo = "feather-font";
    rev = "c51fe7cedbcf2cbf4f1b993cef5d8def612dec1d";
    sha256 = "0hk12bjlsh0j6kd0sz3nwax259afdi6dxws4x88yz5ssxic1ng2j";
  };

  installPhase = ''
    runHook preInstall

    install -D -m 444 src/fonts/feather.ttf -t $out/share/fonts/ttf
    install -D -m 444 src/fonts/feather.woff -t $out/share/fonts/woff

    runHook postInstall
  '';

  meta = with lib; {
    description = "Icon font";
    platforms = platforms.all;
    maintainers = with maintainers; [ mark ];
  };
}
