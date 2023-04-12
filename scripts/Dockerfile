# Builds the home-manager configuration
FROM nixos/nix:2.15.0pre20230411_0a54624

RUN nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable && \
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
    nix-channel --update

# removes conflict
RUN nix-env -e man-db

RUN nix-shell '<home-manager>' -A install

COPY home.nix /root/.config/home-manager/home.nix
COPY apps.nix /root/.config/home-manager/apps.nix
COPY configs /root/.config/home-manager/configs
COPY apps /root/.config/home-manager/apps
COPY media /root/.config/home-manager/media
RUN home-manager build 

# additionally counts the size of all installed packages
CMD du -hc /nix --max-depth 0
