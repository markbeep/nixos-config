# Mark's Personal NixOS Setup

One line install everything:

```bash
nix-shell -p curl -p git --run "curl https://raw.githubusercontent.com/markbeep/nixos-config/main/install.sh | sh"
```

List of commands to copy the setup:

```bash
# temporarily install git in the shell
nix-shell -p git

cd ~
git clone https://github.com/markbeep/NixOS-config ~/nixos-config

# add the unstable and home-manager channels
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# builds the main part using the custom configuration
sudo nixos-rebuild switch -I $HOME/nixos-config/configuration.nix
```

# SSH

For applications that are in private repos (visdev) for example, the private
keys and config needs to be added to the root user .ssh directory, since
nixos-rebuild is ran as root.

# Private Files

Files ending in `.priv` are private and encrypted with
[git-crypt](https://github.com/AGWA/git-crypt). To decrypt them (if you have the
permissions), you can simply run `git-crypt unlock` or `git-crypt unlock
/path/to/file` if a key file is given.
