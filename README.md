# Mark's Personal NixOS Setup

List of commands to copy the setup:

```bash
cd ~
git clone https://github.com/markbeep/NixOS-config ~/nixos-config

# symlink new config to proper location
sudo rm /etc/nixos/configuration.nix /etc/nixos/hardware-configuration.nix
ln -n ~/nixos-config/configuration.nix /etc/nixos/configuration.nix
ln -n ~/nixos-config/hardware-configuration.nix /etc/nixos/hardware-configuration.nix

# add the unstable and home-manager channels
nix-channel --add https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# temporarily get git in the shell
nix-shell -p git

# builds the main part
sudo nixos-rebuild switch
```
