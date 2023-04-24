local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
vim.keymap.set("n", "<leader>vrr", builtin.lsp_references, {})
vim.keymap.set("n", "gd", builtin.lsp_definitions, {})

-- quickly swap to another branch
local telescope = require("telescope")
telescope.load_extension("git_worktree")
vim.keymap.set("n", "<leader>pb",
               telescope.extensions.git_worktree.git_worktrees, {})
