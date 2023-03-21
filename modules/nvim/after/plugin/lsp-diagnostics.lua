require('toggle_lsp_diagnostics').init()

vim.keymap.set("n", "<leader>td", vim.cmd.ToggleDiag)
