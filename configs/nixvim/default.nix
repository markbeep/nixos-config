{ pkgs, config, ... }: {
  programs.nixvim = (import ./config.nix {
    pkgs = pkgs;
    homeDir = config.users.users.mark.home;
  });
}
