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

  home.packages = with pkgs; [
    firefox
    discord
    slack
    kubectl
    krew # package manager for kubectl
    (pkgs.libsForQt5.callPackage ~/nixos-config/nixpkgs/sipctl/default.nix { })
    flameshot # screenshot 
    okular # pdf viewer

    # terminal addons
    neofetch
    htop

    # core
    brightnessctl
    pulseaudio
    killall
    feh # background change
    pavucontrol # audio settings
    pamixer
    autorandr # modify window sizes

    # theming
    imagemagick
    networkmanagerapplet
    picom # allows for transparent applications
    dunst # notifications 
    libnotify # send notifications

    # coding
    neovim
    vscode

    # credentials
    libsecret
    gnome.gnome-keyring
    libgnome-keyring

    # languages
    python311
    nodejs-16_x
    nil # nix lsp
    nixpkgs-fmt
    yarn
    go_1_18

    # fonts
    noto-fonts
    noto-fonts-extra
    liberation_ttf
    dejavu_fonts
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
  ];

  # enables the fonts to be used
  fonts.fontconfig.enable = true;

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

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
