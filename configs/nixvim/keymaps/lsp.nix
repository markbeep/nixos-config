[
    {
        mode = "n";
        key = "<leader>f";
        lua = true;
        action = "function() vim.lsp.buf.format() end";
    }
    {
        mode = "n";
        key = "K";
        lua = true;
        action = "function() vim.lsp.buf.hover() end";
    }
    {
        mode = "n";
        key = "<leader>vws";
        lua = true;
        action = "function() vim.lsp.buf.workspace_symbol() end";
    }
    {
        mode = "n";
        key = "<leader>vd";
        lua = true;
        action = "function() vim.diagnostic.open_float() end";
    }
    {
        mode = "n";
        key = "]d";
        lua = true;
        action = "function() vim.diagnostic.goto_next() end";
    }
    {
        mode = "n";
        key = "[d";
        lua = true;
        action = "function() vim.diagnostic.goto_prev() end";
    }
    {
        mode = "n";
        key = "<leader>vca";
        lua = true;
        action = "function() vim.lsp.buf.code_action() end";
    }
    {
        mode = "n";
        key = "<leader>vrn";
        lua = true;
        action = "function() vim.lsp.buf.rename() end";
    }
    {
        mode = "i";
        key = "<C-S-Space>";
        lua = true;
        action = "function() vim.lsp.buf.signature_help() end";
    }
]
