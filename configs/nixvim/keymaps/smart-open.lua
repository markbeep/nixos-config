local telescope = require("telescope")

vim.keymap.set("n", "<leader>pf", function ()
  require("telescope").extensions.smart_open.smart_open({
    filename_first = true,
  })

end, { noremap = true, silent = true })

telescope.setup {
  extensions = {
    smart_open = {
      match_algorithm = "fzf",
    },
  },
}

telescope.load_extension("smart_open")
