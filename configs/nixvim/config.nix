{ pkgs, homeDir }: {
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

  autoCmd = [{
    event = [ "VimEnter" ];
    pattern = [ "*" ];
    command = "GitBlameDisable";
  }];

  plugins = {
    # LSP
    lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        tailwindcss.enable = true;
        nixd.enable = true;
        gopls.enable = true;
        zls.enable = true;
        ruff-lsp.enable = true;
        lua-ls.enable = true;
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
        sources =
          [ { name = "nvim_lsp"; } { name = "buffer"; } { name = "path"; } ];
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
    surround.enable = true;

    # Theming
    gitsigns.enable = true;
    barbar.enable = true;
    indent-blankline = {
      enable = true;
      settings.scope = {
        show_end = false;
        show_exact_scope = true;
        show_start = true;
      };
    };
    lualine = {
      enable = true;
      theme = "palenight";
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
    dressing-nvim
    tint-nvim
    neoformat
    sqlite-lua
    (pkgs.vimUtils.buildVimPlugin {
      name = "smart-open";
      src = pkgs.fetchFromGitHub {
        owner = "danielfalk";
        repo = "smart-open.nvim";
        rev = "3cff486c7074a23c92339a8916ebe42bb0ffd2bf";
        hash = "sha256-N0lDSYiHY6+IQ2AJ3dxZlNqgan49y/yw050LvvMrZdM=";
      };
    })
  ];
  extraConfigLua = ''
    ${(builtins.readFile ./keymaps/smart-open.lua)}
    ${(builtins.readFile ./keymaps/dressing.lua)}
    ${(builtins.readFile ./keymaps/tint.lua)}
  '';

  extraConfigVim = ''
    ${(builtins.readFile ./keymaps/neoformat.vim)}
  '';

  keymaps = (import ./keymaps) ++  [
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
