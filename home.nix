{ config, pkgs, ... }:

{
  # specific configurations
  imports = [
    ~/nixos-config/modules
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
      firefox
      pkgsUnstable.discord
      slack
      kubectl
      krew # package manager for kubectl
      (pkgs.libsForQt5.callPackage ~/nixos-config/nixpkgs/sipctl/default.nix { })
      flameshot # screenshot 
      okular # pdf viewer
      nomacs # image viewer
      stremio
      vlc
      ghostscript
      anki-bin

      # terminal addons
      neofetch
      htop
      pkgsUnstable.nix-direnv

      # core
      brightnessctl
      pulseaudio
      killall
      pavucontrol # audio settings
      pamixer
      bluez
      bluez-tools # bluetooth
      unzip
      wmctrl # used by vscode glassit extension
      autorandr # modify window sizes
      arandr # gui for handling multiple monitors
      dig

      # theming
      feh # background change
      imagemagick
      networkmanagerapplet
      picom # allows for transparent applications
      dunst # notifications 
      libnotify # send notifications
      pywal # background and color change
      dmenu
      networkmanager_dmenu
      alttab # alt tab menu

      # coding
      neovim
      pkgsUnstable.vscode
      gcc

      # languages
      python311
      nodejs-16_x
      nil # nix lsp
      nixpkgs-fmt
      yarn
      go_1_18
      hugo
      gnumake

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
      (pkgs.libsForQt5.callPackage ~/nixos-config/nixpkgs/feather/default.nix { })
    ];

  # enables the fonts to be used
  fonts.fontconfig.enable = true;

  # setup monitors that are already known
  programs.autorandr = {
    enable = true;
  };

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