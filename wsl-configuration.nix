{ lib, pkgs, modulesPath, ... }:

with lib;
let nixos-wsl = import ./nixos-wsl;
in {
  imports = [
    "${modulesPath}/profiles/minimal.nix"

    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "nixos";
    startMenuLaunchers = true;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = true;

  };

  environment.systemPackages = with pkgs; [ git vim wget direnv nix-direnv ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  system.stateVersion = "22.05";
}
