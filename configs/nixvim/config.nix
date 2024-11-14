{ pkgs, homeDir }:
let
  pinned = import ./plugins.nix pkgs;
in
{
  enable = true;
  viAlias = true;
  vimAlias = true;

  colorschemes.rose-pine.enable = true;

  globals.mapleader = " ";

  opts = {
    nu = true;
    relativenumber = true;
    tabstop = 4;
    softtabstop = 4;
    shiftwidth = 4;
    expandtab = true;
    smartindent = true;
    swapfile = false;
    backup = false;
    undodir = "${homeDir}/.vim/undodir";
    undofile = true;
    hlsearch = false;
    incsearch = true;
    termguicolors = true;
    scrolloff = 8;
    signcolumn = "yes";
    updatetime = 50;
    colorcolumn = "80";
    hidden = true; # allows switching tabs without saving
  };

  autoCmd = [
    {
      event = [ "VimEnter" ];
      pattern = [ "*" ];
      command = "GitBlameDisable";
    }
  ];

  plugins = {
    # LSP
    lsp = {
      enable = true;
      servers = {
        ts_ls.enable = true;
        tailwindcss.enable = true;
        nixd.enable = true;
        gopls.enable = true;
        zls.enable = true;
        ruff_lsp.enable = true;
        dockerls.enable = true;
        lua_ls.enable = true;
        ccls.enable = true;
      };
    };
    cmp = {
      enable = true;
      settings = {
        mapping = {
          __raw = ''
            cmp.mapping.preset.insert({
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-e>'] = cmp.mapping.close(),
              ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
              ['<S-Tab>'] = cmp.mapping.select_prev_item()
            })
          '';
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };
    };

    telescope = {
      enable = true;
      extensions = {
        fzf-native = {
          enable = true;
          settings = {
            fuzzy = true;
            override_file_sorter = true;
            override_generic_sorter = true;
            case_mode = "smart_case";
          };
        };
      };
    };

    treesitter.enable = true;
    treesitter-context.enable = true;
    comment.enable = true;
    gitblame.enable = true;
    trouble.enable = true;
    todo-comments.enable = true;
    fugitive.enable = true;
    nvim-autopairs.enable = true;
    diffview.enable = true;
    oil.enable = true;
    undotree.enable = true;
    fzf-lua.enable = true;
    copilot-vim.enable = true;
    vim-surround.enable = true;
    web-devicons.enable = true;

    # Theming
    gitsigns.enable = true;
    barbar.enable = true;
    lualine = {
      enable = true;
      # settings.options.theme = "palenight";
    };

    # Languages
    nix.enable = true;
    zig.enable = true;
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-wakatime
    vim-sleuth # adjusts shiftwidth/expandtab correctly
    vim-be-good
    nerdtree
    tint-nvim
    neoformat
    nvim-spectre
    pinned.startup
    pinned.sqlite
    pinned.smart-open
  ];
  extraConfigLua = ''
    ${builtins.readFile ./keymaps/smart-open.lua}
    ${builtins.readFile ./keymaps/spectre.lua}
    ${builtins.readFile ./keymaps/tint.lua}
  '';

  extraConfigVim = ''
    let g:sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'
    ${(builtins.readFile ./keymaps/neoformat.vim)}
  '';

  keymaps = (import ./keymaps) ++ [
    {
      key = "<leader>b";
      action = "<cmd>GitBlameToggle<CR>";
      mode = "n";
    }
    {
      key = "<leader>tr";
      action = "<cmd>TroubleToggle<CR>";
      mode = "n";
    }
    {
      key = "<leader>gs";
      action = "<cmd>Git<CR>";
      mode = "n";
    }
  ];
}
