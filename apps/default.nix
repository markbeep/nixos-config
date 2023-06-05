# all installed user apps
{ pkgs, ... }:
with pkgs;
import ./coding.nix pkgs ++
import ./core.nix pkgs ++
import ./fonts.nix pkgs ++
import ./terminal.nix pkgs ++
import ./theming.nix pkgs ++
import ./vis.nix pkgs
