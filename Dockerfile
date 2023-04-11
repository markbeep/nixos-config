# Builds the home-manager configuration
FROM nixos/nix:2.15.0pre20230411_0a54624

RUN nix-channel --add https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz unstable && \
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
    nix-channel --update

# removes conflict
RUN nix-env -e man-db

RUN nix-shell '<home-manager>' -A install

COPY home.nix /root/.config/home-manager/home.nix
COPY modules /root/.config/home-manager/modules
COPY apps /root/.config/home-manager/apps
RUN home-manager build 

# additionally counts the size of all installed packages
RUN du -hc /nix --max-depth 0
