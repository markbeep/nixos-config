{pkgs, config, ...}: {
  programs.nixvim = {
    enable = true;

    colorschemes.rose-pine.enable = true;

    globals.mapleader = " ";

    options = {
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
        };
      };
      nvim-cmp = {
        enable = true;
        mappingPresets = [ "insert" ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
          "<S-Tab>" = {
            action = "cmp.mapping.select_prev_item()";
            modes = [
              "i"
              "s"
            ];
          };
          "<Tab>" = {
            action = "cmp.mapping.select_next_item()";
            modes = [
              "i"
              "s"
            ];
          };
        };
        sources = [
          {name="nvim_lsp";}
          {name="buffer";}
          {name="path";}
        ];
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
      comment-nvim.enable = true;
      gitblame.enable = true;
      trouble.enable = true;
      todo-comments.enable = true;
      fugitive.enable = true;

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
    ];

    keymaps =
    (import ./keymaps) ++
    (import ./keymaps/lsp.nix) ++
    (import ./keymaps/barbar.nix) ++
    (import ./keymaps/todo.nix) ++
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
