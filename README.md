# Mark's Personal NixOS Setup

List of commands to copy the setup:

```bash
# temporarily install git in the shell
nix-shell -p git

cd ~
git clone https://github.com/markbeep/NixOS-config ~/nixos-config

# add the unstable and home-manager channels
nix-channel --add https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# builds the main part using the custom configuration
sudo nixos-rebuild switch -I $HOME/nixos-config/configuration.nix
```
