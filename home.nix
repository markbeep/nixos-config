{ config, pkgs, ... }:
{
  # specific configurations
  imports = [
    ./modules
  ];


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mark";
  home.homeDirectory = "/home/mark";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  home.packages =
    let
      # for installing specific unstable packages
      pkgsUnstable = import <unstable> {
        config.allowUnfree = true;
      };
    in
    with pkgs;[
      # regular applications
      firefox
      pkgsUnstable.discord
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

      # kubernetes / VIS
      kubectl
      krew # package manager for kubectl
      (pkgs.libsForQt5.callPackage ./apps/sipctl/default.nix { })
      (pkgs.libsForQt5.callPackage ./apps/servis/default.nix { })
      # only attempts to install if ssh keys are setup. Installs hello otherwise
      (if builtins.pathExists ~/.ssh then (pkgs.libsForQt5.callPackage ./apps/visdev/default.nix { }) else hello)

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
      
      unzip

      # theming
      imagemagick
      networkmanagerapplet
      picom # allows for transparent applications
      pywal # background and color change
      dmenu
      dunst # notifications
      networkmanager_dmenu
      batsignal # battery notifications
      pkgsUnstable.stylish # automatic background fetching

      # coding
      # neovim # installed in modules
      pkgsUnstable.vscode-fhs
      xclip # required for nvim copy/pasting

      # languages
      nodejs-16_x
      nixpkgs-fmt
      yarn
      go_1_18
      hugo
      gnumake
      gcc

      # LSP tools
      nil # nix lsp

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
    ];

  # handles direnv setups in projects
  services.lorri.enable = true;

  # enables the fonts to be used
  fonts.fontconfig.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";
}
