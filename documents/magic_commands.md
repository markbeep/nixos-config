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

## Multiple Monitors
Add monitor to the right with 1.5 scale (zoom out)
`xrandr --output DP1 --scale 1.5x1.5 --right-of eDP1`
