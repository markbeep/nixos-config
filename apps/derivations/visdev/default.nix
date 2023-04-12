{ lib, stdenv, pkgs }:
let
  pythonPackages = pkgs.python310Packages;
in
pythonPackages.buildPythonPackage {
  name = "visdev";
  version = "0.0.1";

  src = fetchGit {
    url = "git@gitlab.ethz.ch:vis/cat/visdev.git";
    ref = "master";
    rev = "96cdf01cbd3665122a37dd80f2628931f952edce";
  };

  propagatedBuildInputs = [
    pythonPackages.docopt
    pythonPackages.pyaml
    pythonPackages.docker
  ];

  meta = with lib; {
    description = "visdev is a utility that should help you develop applications for VIS by simulating the production environment.";
    homepage = "https://gitlab.ethz.ch/vis/cat/visdev";
    platforms = platforms.linux;
    maintainers = [ maintainers.markbeep ];
  };

}
