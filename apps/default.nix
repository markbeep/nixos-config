# all installed user apps
{ pkgs, ... }:
let
  # for installing specific unstable packages
  unstable = import <unstable> { config.allowUnfree = true; };
in
with pkgs; 
import ./coding.nix pkgs unstable ++
import ./core.nix pkgs unstable ++
import ./fonts.nix pkgs unstable ++
import ./terminal.nix pkgs unstable ++
import ./theming.nix pkgs unstable ++
import ./vis.nix pkgs unstable
