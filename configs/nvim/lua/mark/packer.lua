local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') ..
                             '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            'git', 'clone', '--depth', '1',
            'https://github.com/wbthomason/packer.nvim', install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd [[packadd packer.nvim]]

-- :PackerSync to update
return require('packer').startup(function(use)
    -- Packer itself
    use 'wbthomason/packer.nvim'

    use('ThePrimeagen/harpoon') -- bookmark files
    use('wakatime/vim-wakatime') -- track time spent
    use('ThePrimeagen/vim-be-good') -- vim game
    use('mbbill/undotree') -- crispy undo tree

    -- Telescope
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'

    -- Theming
    use {'romgrk/barbar.nvim', requires = 'nvim-tree/nvim-web-devicons'}
    use "lukas-reineke/indent-blankline.nvim"
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function() vim.cmd('colorscheme rose-pine') end
    })
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    -- Un/Comment Lines
    use {
        'numToStr/Comment.nvim',
        config = function() require('Comment').setup() end
    }

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/nvim-treesitter-context')

    -- Handle shiftwidth
    use('tpope/vim-sleuth')

    -- Git
    use 'ThePrimeagen/git-worktree.nvim'
    use('lewis6991/gitsigns.nvim')
    use('tveskag/nvim-blame-line')
    use('tpope/vim-fugitive')

    -- LSP
    use 'VonHeikemen/lsp-zero.nvim'
    use 'L3MON4D3/LuaSnip'
    use {
        "williamboman/mason.nvim",
        run = ":MasonUpdate" -- :MasonUpdate updates registry contents
    }
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'jay-babu/mason-null-ls.nvim'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'rafamadriz/friendly-snippets'
    use 'williamboman/mason-lspconfig.nvim'

    -- show errors
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function() require("trouble").setup {} end
    }

    -- LaTeX
    use 'lervag/vimtex'
end)
