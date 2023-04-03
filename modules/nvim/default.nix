{pkgs, ...}:
{
  home.file.".config/nvim/after".source = ./after;
  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua".source = ./lua;
  home.file.".config/nvim/utils".source = ./utils;
  programs = {
    neovim = {
      enable = true;
      extraPackages = with pkgs; [
        lua51Packages.luarocks # for lua formatter
        cmake
      ];
    };
  };
}
