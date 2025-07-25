{ config, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./configs/nixvim
    ./configs/physlock.nix
  ];

  users.users.mark = {
    isNormalUser = true;
    description = "Mark";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;

  # obsidian uses EOL Electron 25.9.0
  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  # enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # reduce file size used & automatic garbage collector
  nix.settings.auto-optimise-store = true;
  # GC is handled by Nix Helper
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 14d";
  };

  # required for nix-direnv to work and have environments not garbage collected
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

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
    extraHosts = ''
      127.0.0.1 minio
      127.0.0.1 eventmanager-minio
    '';

    # Enable networking
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Zurich";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.displayManager.ly.enable = true;
  # ly is used as the DM currently
  # services.displayManager.gdm.enable = true;

  # Enable the i3 window manager
  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3blocks
        rofi
        polybarFull
      ];
    };

    # Increase touchpad acceleration
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xinput} set-prop "SYNA1D31:00 06CB:CD48 Touchpad" "libinput Accel Speed" 0.3
    '';

    # Configure keymap in X11
    xkb.layout = "ch,us";
    xkb.options = "grp:alt_space_toggle";
  };

  # Enable touchpad support
  services.libinput = {
    enable = true;
    mouse.accelSpeed = "0.2";
  };

  # Enable i3blocks to find the correct /etc
  environment.pathsToLink = [ "/libexec" ];

  # Configure console keymap
  console.keyMap = "sg";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # enable signed commits in git
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  # Nix Helper. More thorough nix garbage collector
  programs.nh = {
    enable = true;
    clean.enable = false; # Also clears project envs
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/mark/nixos-config";
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-utils # for opening default programs when clicking links

    # essentials
    home-manager
    wget
    i3
    file
    xfce.thunar # file manager
    ranger # terminal file manager
    xdragon # required for ranger drag'n'drop (<C-d>)

    # terminal
    fish
    kitty
    st
    mesa-demos

    # developing
    git
    vim
    docker

    # credentials
    libsecret
    gnome-keyring
    libgnome-keyring

    # signed git commits
    gnupg
    pinentry-qt

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

  zramSwap.enable = true;

  # disabled 21.07.2025 for nixos-hardware power-profiles setting
  # services.tlp = {
  #   enable = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
