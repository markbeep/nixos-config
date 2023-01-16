# Mark's Personal NixOS Setup

Put this repository into your home directory, symlink the configs and rebuild the system:
```bash
cd ~
git clone <repo url here>
sudo rm /etc/nixos/configuration.nix /etc/nixos/hardware-configuration.nix
ln -n ~/nixos-config/configuration.nix /etc/nixos/configuration.nix
ln -n ~/nixos-config/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo nixos-rebuild switch
```

Then symlink home-manager and setup all the configs there:
```bash
ln -n ~/nixos-config/home.nix ~/.config/nixpkgs/home.nix
home-manager switch
```

