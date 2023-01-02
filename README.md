Simply clap this repo into your home directory

```bash
cd ~
git clone ...
sudo rm /etc/nixos/configuration.nix /etc/nixos/hardware-configuration.nix
ln -n ~/nixos-config/configuration.nix /etc/nixos/configuration.nix
ln -n ~/nixos-config/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo nixos-rebuild switch
```

This will then setup everything.
