{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  users.users.mark = {
    isNormalUser = true;
    description = "Mark";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-16.20.0"
  ];
  nixpkgs.config.allowUnfree = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # reduce file size used & automatic garbage collector
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # Bootloader.
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot/efi";
  };
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };

  networking = {
    hostName = "mark_laptop";

    # extra hosts in /etc/hosts file
    extraHosts =
      ''
        127.0.0.1 minio
      '';

    # Enable networking
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the i3 window manager 
  services.xserver = {
    enable = true;

    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "mark";
      extraConfig = ''
        [greeter]
        show-password-label = false
        [greeter-theme]
        background-image = "/home/mark/nixos-config/media/synth-car.jpg"
      '';
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3blocks
        rofi
        polybarFull
        betterlockscreen
        xss-lock # to lock on suspend
        lightdm # display manager
      ];
    };

    # removes screen tearing
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "true"
    '';
  };

  # Enable i3blocks to find the correct /etc
  environment.pathsToLink = [ "/libexec" ];

  # Configure keymap in X11
  services.xserver = {
    layout = "ch";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support
  services.xserver.libinput.enable = true;

  # enable signed commits in git
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    # essentials
    home-manager
    wget
    i3
    file
    xfce.thunar # file manager
    xorg.xf86videointel

    # terminal
    fish
    kitty

    # developing
    git
    vim
    docker

    # credentials
    libsecret
    gnome.gnome-keyring
    libgnome-keyring

    powertop # optimizes battery usage

    # signed git commits
    gnupg
    pinentry-curses

    # filestash
    cifs-utils
  ];

  services.gnome.gnome-keyring.enable = true;

  # Thunar specific
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  programs.fish.enable = true;

  # enables docker to work and be run rootless
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  fileSystems."/mnt/vseth" = {
    device = "//nas22.ethz.ch/eth_vseth_nas_2";
    fsType = "cifs";
    options = [
      "username=mcsurgay"
      "domain=d.ethz.ch,noauto,user"
      "vers=3.0"
    ];
  };

  powerManagement.powertop.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}
