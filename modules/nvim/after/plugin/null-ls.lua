local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettierd,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
    },
})

local formatting = null_ls.builtins.formatting

formatting.prettierd.with({
	extra_filetypes = { "toml" },
	env = {
		PRETTIERD_DEFAULT_CONFIG = vim.fn.expand(
		"~/.config/nvim/utils/prettier-config/.prettierrc.json"
		),
	},
})
