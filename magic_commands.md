## Airplane Mode on/off:
nmcli r all [on|off]

## WiFi
list wifi:
nmcli device

connect to WiFi:
nmcli device connect <ssid> password <password>

## Fonts
Find the exact name of a font:
fc-list

## Test Build Custom Package
`nix-build -E "with import <nixpkgs> {}; callPackage ./default.nix {}"`
