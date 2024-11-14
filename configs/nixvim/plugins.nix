{ pkgs, ... }:
{
  smart-open = pkgs.vimUtils.buildVimPlugin {
    name = "smart-open";
    src = pkgs.fetchFromGitHub {
      owner = "danielfalk";
      repo = "smart-open.nvim";
      rev = "f4e39e9a1b05a6b82b1182a013677acc44b27abb";
      hash = "sha256-bEo5p7tHeoE13P8QsjC8RqNA0NMogjdYzN0oatQaIJY=";
    };
  };

  # manually build sqlite.lua, since the vimPlugins.sqlite-lua has a syntax error
  # sqlite.lua is required for smart-open
  sqlite = pkgs.vimUtils.buildVimPlugin {
    name = "sqlite.lua";
    src = pkgs.fetchFromGitHub {
      owner = "kkharji";
      repo = "sqlite.lua";
      rev = "v1.2.2";
      hash = "sha256-NUjZkFawhUD0oI3pDh/XmVwtcYyPqa+TtVbl3k13cTI=";
    };
  };

  startup = pkgs.vimUtils.buildVimPlugin {
    name = "startup";
    src = pkgs.fetchFromGitHub {
      owner = "dstein64";
      repo = "vim-startuptime";
      rev = "v4.5.0";
      hash = "sha256-hQ7/e7vEJx3j4CQfA6zkQFSe6wrFc9URZ2z47ZulW9A=";
    };
  };
}
