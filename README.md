# Mark's Personal NixOS Setup

The configuration is set up using a flake. You can theoretically rebuild the system
by just running the following nixos rebuild command:
```bash
nixos-rebuild switch --flake github:markbeep/NixOS-config#mark
```

One line install everything:

```bash
nix-shell -p curl -p git --run "curl https://raw.githubusercontent.com/markbeep/nixos-config/main/install.sh | sh"
```

List of commands to copy the setup and having the setup locally:

```bash
# temporarily install git in the shell
nix-shell -p git

cd ~
git clone https://github.com/markbeep/NixOS-config ~/nixos-config
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


### WSL
The WSL configuration can be used to quickly set up a WSL instance running NixOS.

Follow the documentation in the [NixOS-WSL repo](https://github.com/nix-community/NixOS-WSL) to install NixOS in WSL. Then copy the `wsl-configuration.nix` to /etc/nixos/configuration.nix and run `sudo nixos-rebuild switch`.

To finish setting up direnv, the following line has to be added to `~/.bashrc`:
```
eval "$(direnv hook bash)"
```
