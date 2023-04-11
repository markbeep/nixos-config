# Script used to easily install everything needed in one go
cd ~
echo "Cloning repo"
git clone https://github.com/markbeep/NixOS-config ~/nixos-config

# add the unstable and home-manager channels
echo "Adding channels"
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# builds the main part using the custom configuration
echo "Rebuilding system (requires root)"
sudo nixos-rebuild switch -I $HOME/nixos-config/configuration.nix
