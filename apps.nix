# all installed user apps
{ pkgs, ... }:
let
  # for installing specific unstable packages
  unstable = import <unstable> { config.allowUnfree = true; };
in
with pkgs; [
  # regular applications
  firefox
  unstable.discord
  slack
  flameshot # screenshot
  okular # pdf viewer
  nomacs # image viewer
  stremio
  vlc
  anki-bin
  anydesk
  filezilla
  keepass
  unzip

  # kubernetes / VIS
  kubectl
  krew # package manager for kubectl
  (pkgs.libsForQt5.callPackage ./apps/sipctl/default.nix { })
  (pkgs.libsForQt5.callPackage ./apps/servis/default.nix { })
  # only attempts to install if ssh keys are setup. Installs hello otherwise
  (if builtins.pathExists ~/.ssh then
    (pkgs.libsForQt5.callPackage ./apps/visdev/default.nix { })
  else
    hello)

  # terminal addons
  neofetch
  htop
  # auto load environment
  direnv
  nix-direnv
  fzf
  ripgrep # required for nvim grep
  xdotool

  # core
  brightnessctl
  killall
  arandr # gui for handling multiple monitors

  # audio settings
  pulseaudio
  pavucontrol
  pamixer

  # bluetooth
  bluez
  bluez-tools

  # theming
  imagemagick
  networkmanagerapplet
  picom # allows for transparent applications
  pywal # background and color change
  dmenu
  dunst # notifications
  networkmanager_dmenu
  batsignal # battery notifications
  unstable.stylish # automatic background fetching

  # coding
  # neovim # installed in configs
  unstable.vscode-fhs
  xclip # required for nvim copy/pasting

  # languages
  nodejs-16_x
  yarn
  go_1_18
  hugo
  gnumake
  gcc

  # LSP tools
  nil # nix lsp
  statix
  nixpkgs-fmt

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
  (pkgs.libsForQt5.callPackage ./apps/feather/default.nix { })

  # latex
  texlive.combined.scheme-full
]
