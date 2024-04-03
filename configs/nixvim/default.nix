{pkgs, config, ...}: {
  programs.nixvim = {
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
      undodir = "${config.users.users.mark.home}/.vim/undodir";
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
          tsserver.enable = true;
          tailwindcss.enable = true;
          nixd.enable = true;
          gopls.enable = true;
          zls.enable = true;
          pyright.enable = true;
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
            {name="nvim_lsp";}
            {name="buffer";}
            {name="path";}
          ];
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>pf" = "find_files";
          "<C-p>" = "git_files";
          "<leader>ps" = "live_grep";
          "<leader>vrr" = "lsp_references";
          "gd" = "lsp_definitions";
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

      # Theming
      gitsigns.enable = true;
      barbar.enable = true;
      indent-blankline.enable = true;
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
      vim-sleuth
      vim-be-good
      nerdtree
      dressing-nvim
      tint-nvim
    ];
    extraConfigLua = ''
      ${(builtins.readFile ./keymaps/dressing.lua)}
      ${(builtins.readFile ./keymaps/tint.lua)}
    '';

    keymaps =
    (import ./keymaps) ++
    (import ./keymaps/lsp.nix) ++
    (import ./keymaps/barbar.nix) ++
    (import ./keymaps/todo.nix) ++
    (import ./keymaps/nerdtree.nix) ++
    [
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
  };
}
