{ pkgs, ... }: {
  # specific configurations
  imports = [ ./configs ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mark";
  home.homeDirectory = "/home/mark";

  home.packages = import ./modules.nix {pkgs = pkgs;};

  # direnv
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # enables the fonts to be used
  fonts.fontconfig.enable = true;

  # TODO: Added 01.08.2025. Look into removing/fixing properly
  # Hot-fix for "Unit tray.target not found." preventing flameshot from launching.
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session.target" ];
    };
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
