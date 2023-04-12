require("mason").setup()

-- use specific config for formatting with prettier
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        -- js/ts
        null_ls.builtins.formatting.prettierd.with({
            extra_filetypes = {"toml"},
            extra_args = {"--arrow-parens avoid", "--trailing-comma all"}
        })
    }
})

require("mason-null-ls").setup({automatic_setup = true, handlers = {}})

vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, {})
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})
vim.keymap.set("n", "<leader>vws",
               function() vim.lsp.buf.workspace_symbol() end, {})
vim.keymap
    .set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {})
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, {})
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, {})
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, {})
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, {})
vim.keymap.set("i", "<C-Space>", function() vim.lsp.buf.completion() end, {})
vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, {})

-- nix lsp
-- local lsp_path = vim.env.NIL_PATH or 'target/debug/nil'
-- require('lspconfig').nil_ls.setup {
--   autostart = true,
--   capabilities = caps,
--   cmd = { lsp_path },
--   settings = {
--     ['nil'] = {
--       testSetting = 42,
--       formatting = {
-- 	command = { "nixpkgs-fmt" },
--       },
--     },
--   },
-- }
