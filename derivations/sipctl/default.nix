{ lib, stdenv, fetchurl, autoPatchelfHook, installShellFiles }:
stdenv.mkDerivation {
  name = "sipctl";
  version = "0.0.1";

  # luckily these urls stay consistent
  src = fetchurl {
    url = "https://tools.vseth.ethz.ch/sipctl/linux-amd64/sipctl";
    sha256 = "sha256-85cTZT1Sz8mxelCyah4rL7XdkSFgIbIRQmbhWXU9Mdo=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  nativeBuildInputs = [
    # required for binary to be executable
    autoPatchelfHook
    installShellFiles
  ];

  installPhase = ''
    runHook preInstall
    
    install -Dm755 $src $out/bin/sipctl
    autoPatchelf $out/bin/sipctl
    
    runHook postInstall
  '';

  postInstall = ''
    ls -ah $out/bin
    
    installShellCompletion --cmd sipctl \
    --bash <($out/bin/sipctl completion bash) \
    --fish <($out/bin/sipctl completion fish) \
    --zsh <($out/bin/sipctl completion zsh)
  '';

  meta = with lib; {
    description = "This is a command-line tool to interact with SIP.\
    It is meant to support the same tasks as Gatekeeper.";
    homepage = "https://wiki.vseth.ethz.ch/display/0403DE/SIP";
    platforms = platforms.linux;
    maintainers = [ maintainers.markbeep ];
  };

}
