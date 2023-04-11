# Tests the whole configuration file
{ pkgs ? import <nixpkgs> {} } :
pkgs.nixosTest {
  name = "test-main";
  nodes.machine = import ./configuration.nix;
  testScript = ''
    machine.execute("vim -c exit")
  '';
}
