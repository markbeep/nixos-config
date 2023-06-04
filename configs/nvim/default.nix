{ pkgs, ... }:
{
  home.file.".config/nvim/after".source = ./after;
  home.file.".config/nvim/init.lua".source = ./init.lua;
  home.file.".config/nvim/lua".source = ./lua;
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      withPython3 = true;
      withRuby = false;
      withNodeJs = true;

      plugins = with pkgs; [
        vimPlugins.markdown-preview-nvim
      ];

      extraPackages = with pkgs; [
        lua51Packages.luarocks # for lua formatter
        cmake
      ];
    };
  };
}
