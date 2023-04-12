# Tests the whole configuration file
{ pkgs ? import <nixpkgs> { } }:
let
  pkgs = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-22.11.tar.gz) { };
  unstable = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz) { config.allowUnfree = true; };
in
pkgs.nixosTest {
  name = "coding";
  nodes.machine = { pkgs, ... }: {
    environment.systemPackages = import ../apps/coding.nix pkgs unstable;
  };
  testScript = "";
}
