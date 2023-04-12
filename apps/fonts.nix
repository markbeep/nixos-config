pkgs: unstable: with pkgs; [
  # fonts
  noto-fonts
  noto-fonts-extra
  liberation_ttf
  dejavu_fonts
  open-sans
  fantasque-sans-mono
  terminus_font
  material-icons
  (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
  (pkgs.libsForQt5.callPackage ./derivations/feather/default.nix { })
]
