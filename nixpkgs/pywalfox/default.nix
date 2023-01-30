{ lib, pkgs, stdenv, fetchFromGitHub }:
let
  version = "2.7.4";
  src = fetchFromGitHub {
    owner = "Frewacom";
    repo = "pywalfox-native";
    rev = version;
    sha256 = "sha256-xPZ0WFo8sbNI2I5BCPPI3QRU8lcqnm925M2C5JiSKmE=";
  };
in
pkgs.python310Packages.buildPythonPackage
{
  name = "pywalfox";
  inherit version;
  src = pkgs.python310.pkgs.fetchPypi {
    pname = "pywalfox";
    version = "2.7.4";
    sha256 = "sha256-Wec9fic4lXT7gBY04D2EcfCb/gYoZcrYA/aMRWaA7WY=";
  };

  postInstall = ''
    chmod +x $out/lib/python3.10/site-packages/pywalfox/bin/main.sh
  '';

  meta = with lib; {
    description = "Native messaging host";
    longDescription = "Dynamic theming of Firefox (and Thunderbird) using your Pywal colors";
    homepage = "https://github.com/Frewacom/pywalfox-native";
    platforms = platforms.all;
    maintainers = [ maintainers.markbeep ];
  };
}
