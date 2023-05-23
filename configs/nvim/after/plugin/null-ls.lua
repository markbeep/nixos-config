require("mason").setup()

-- use specific config for formatting with prettier
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.code_actions

null_ls.setup({
    sources = {
        -- js/ts
        formatting.prettierd.with({
            extra_filetypes = {"toml"},
            extra_args = {"--arrow-parens avoid", "--trailing-comma all"}
        }), -- nix
        formatting.nixpkgs_fmt, diagnostics.statix, completion.statix
    }
})

require("mason-null-ls").setup({automatic_setup = true, handlers = {}})

-- autocompletion
local cmp = require 'cmp'
cmp.setup {
    sources = {{name = 'nvim_lsp'}, {name = 'ultisnips'}},
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    snippet = {expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end}
}

-- lsp
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup {automatic_installation = false}

local lspconfig = require('lspconfig')
lspconfig.java_language_server.setup {
    cmd = {'/home/mark/.nix-profile/bin/java-language-server'}
}

-- removes the text from the diagnostics
vim.diagnostic.config {
    virtual_text = false,
    update_in_insert = true,
    signs = true
}

vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, {})
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, {})
vim.keymap.set("n", "<leader>vws",
               function() vim.lsp.buf.workspace_symbol() end, {})
vim.keymap
    .set("n", "<leader>vd", function() vim.diagnostic.open_float() end, {})
vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, {})
vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, {})
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, {})
vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, {})
vim.keymap.set("i", "<C-S-Space>", function() vim.lsp.buf.signature_help() end, {})

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            capabilities = lsp_capabilities,
            on_attach = on_attach
        })
    end
})
