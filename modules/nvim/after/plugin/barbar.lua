vim.keymap.set("n", "<A-,>", vim.cmd.BufferPrevious)
vim.keymap.set("n", "<A-.>", vim.cmd.BufferNext)


vim.keymap.set("n", "<A-<>", vim.cmd.BufferMovePrevious)
vim.keymap.set("n", "<A->>", vim.cmd.BufferMoveNext)


vim.keymap.set("n", "<A-1>", function() vim.cmd.BufferGoto(1) end)
vim.keymap.set("n", "<A-2>", function() vim.cmd.BufferGoto(2) end)
vim.keymap.set("n", "<A-3>", function() vim.cmd.BufferGoto(3) end)
vim.keymap.set("n", "<A-4>", function() vim.cmd.BufferGoto(4) end)
vim.keymap.set("n", "<A-5>", function() vim.cmd.BufferGoto(5) end)
vim.keymap.set("n", "<A-6>", function() vim.cmd.BufferGoto(6) end)
vim.keymap.set("n", "<A-7>", function() vim.cmd.BufferGoto(7) end)
vim.keymap.set("n", "<A-8>", function() vim.cmd.BufferGoto(8) end)
vim.keymap.set("n", "<A-9>", function() vim.cmd.BufferGoto(9) end)
vim.keymap.set("n", "<A-0>", function() vim.cmd.BufferGoto(0) end)

vim.keymap.set("n", "<A-c>", vim.cmd.BufferClose)
