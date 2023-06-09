# all installed user apps
{ pkgs, ... }:
with pkgs;
[
  # regular applications
  firefox
  discord
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
  arandr # monitor setup GUI
  # neovim # installed in configs
  vscode
  xclip # required for nvim copy/pasting
  unzip

  # audio settings
  pulseaudio
  pavucontrol
  pamixer
  brightnessctl
  killall


  # languages
  nodejs-16_x
  yarn
  go_1_18
  gnumake
  gcc

  # LSP tools
  nil # nix lsp
  statix
  nixpkgs-fmt
  java-language-server
  maven # required for java-language-server

  # latex
  texlive.combined.scheme-full

  git-lfs
  git-crypt


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


  # terminal addons
  neofetch
  htop
  direnv # auto load environment
  nix-direnv
  fzf
  ripgrep # required for nvim grep
  xdotool
  fd


  # theming
  imagemagick
  networkmanagerapplet
  picom # allows for transparent applications
  pywal # background and color change
  dmenu
  dunst # notifications
  networkmanager_dmenu
  batsignal # battery notifications
  stylish # automatic background fetching


  # kubernetes / VIS
  kubectl
  krew # package manager for kubectl
  (pkgs.libsForQt5.callPackage ./derivations/sipctl/default.nix { })
  (pkgs.libsForQt5.callPackage ./derivations/servis/default.nix { })
  # only attempts to install if ssh keys are setup. Installs hello otherwise
  (if builtins.pathExists /root/.ssh then
    (pkgs.libsForQt5.callPackage ./derivations/visdev/default.nix { })
  else
    hello)
]