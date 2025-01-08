{ config, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./configs/nixvim
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

  # Missing in current nixpkgs version. Will be added
  # services.displayManager.ly.enable = true;

  # Enable the i3 window manager
  services.xserver = {
    enable = true;

    displayManager.gdm.enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status
        i3blocks
        rofi
        polybarFull
        betterlockscreen
        xscreensaver # to lock screen
      ];
    };

    # Increase touchpad acceleration
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xinput} set-prop "SYNA1D31:00 06CB:CD48 Touchpad" "libinput Accel Speed" 0.3
    '';

    # TODO:: Commented out on 24.10.2024 to fix nvidia driver not starting.
    # This reintroduced screen-tearing and slight graphical issues.
    # videoDrivers = [
    #   "intel"
    #   "nvidia"
    # ];

    # Configure keymap in X11
    xkb.layout = "ch,us";
    xkb.options = "grp:alt_space_toggle";
  };

  # Enable touchpad support
  services.libinput = {
    enable = true;
    mouse.accelSpeed = "0.2";
  };

  hardware.nvidia = {
    prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    modesetting.enable = true;
    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.stable ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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
    pinentryPackage = pkgs.pinentry-curses;
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

  zramSwap.enable = true;

  services.tlp = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
