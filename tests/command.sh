nix --experimental-features 'nix-command flakes' build -L '.#nixosConfigurations.mark.config.system.build.toplevel'
