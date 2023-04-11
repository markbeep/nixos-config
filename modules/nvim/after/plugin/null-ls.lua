require("mason").setup()

-- use specific file for formatting with prettier
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd.with({
            extra_filetypes = {"toml"},
            env = {
                PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
                    "~/.config/nvim/utils/prettier-config/.prettierrc.json")
            }
        })
    }
})

require("mason-null-ls").setup({
    ensure_installed = nil,
    automatic_installation = true,
    automatic_setup = true
})

vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, opts)
