# all installed user apps
{ pkgs, ... }:
with pkgs; [
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
  helix
  xclip # required for nvim copy/pasting
  unzip
  obsidian

  # audio settings
  pulseaudio
  pavucontrol
  pamixer
  brightnessctl

  # languages
  yarn
  go_1_20
  gnumake
  gcc

  # LSP tools
  nil # nix lsp
  statix
  nixfmt

  git-lfs
  git-crypt

  # fonts
  noto-fonts
  noto-fonts-extra
  liberation_ttf
  dejavu_fonts
  open-sans
  material-icons
  (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Iosevka" ]; })
  (pkgs.callPackage ./derivations/feather/default.nix { })

  # terminal addons
  neofetch
  htop
  btop
  k9s
  direnv # auto load environment
  nix-direnv
  fzf
  ripgrep # required for nvim grep
  xdotool
  fd
  atuin

  # theming / services
  imagemagick
  picom # allows for transparent applications
  pywal # background and color change
  dmenu
  networkmanagerapplet
  dunst # notifications
  networkmanager_dmenu
  batsignal # battery notifications

  # kubernetes / VIS
  kubectl
  krew # package manager for kubectl
  (pkgs.callPackage ./derivations/sipctl/default.nix { })
  (pkgs.callPackage ./derivations/servis/default.nix { })
  (pkgs.callPackage ./derivations/servisctl/default.nix { })
  # only attempts to install if ssh keys are setup. Installs hello otherwise
  (if builtins.pathExists /root/.ssh then
    (pkgs.callPackage ./derivations/visdev/default.nix { })
  else
    hello)

  (pkgs.callPackage ./derivations/tigerjython/default.nix { })
]
