{ lib, stdenv }:
stdenv.mkDerivation {
  name = "ramfetch";
  version = "unstable-2023-03-14";

  # luckily these urls stay consistent
  src = fetchGit {
    url = "https://codeberg.org/o69mar/ramfetch.git";
    rev = "5487972ea7485781446d4714675fb30c683bf0c3";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/bin"
    chmod 755 ramfetch
    mv ramfetch $out/bin/ramfetch

    runHook postInstall
  '';

  meta = with lib; {
    description = "ramfetch is a \"fetch\" tool which displays memory info using /proc/meminfo";
    homepage = "https://codeberg.org/o69mar/ramfetch";
    platforms = platforms.all;
    license = licenses.unfree;
    maintainers = [ maintainers.markbeep ];
  };

}
