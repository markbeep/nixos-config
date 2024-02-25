[
    # file explorer
    {
        mode = "n";
        key = "<leader>pv";
        action = "<cmd>Ex<CR>";
    }

    # move selected lines up and down with J or K
    {
        mode = "v";
        key = "J";
        action = ":m '>+1<CR>gv=gv";
    }
    {
        mode = "v";
        key = "K";
        action = ":m '<-2<CR>gv=gv";
    }

    # paste without clearing paste register
    {
        mode = "v";
        key = "<leader>p";
        action = "\"_dP";
    }

    # allows copying to clipboard with <leader>y
    {
        mode = "n";
        key = "<leader>y";
        action = "\"+y";
    }
    {
        mode = "v";
        key = "<leader>y";
        action = "\"+y";
    }
    {
        mode = "n";
        key = "<leader>Y";
        action = "\"+Y";
    }

    # disable Q
    {
        mode = "n";
        key = "Q";
        action = "<nop>";
    }

    # centers on jumping down screen
    {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
    }
    {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
    }

    # centers search results
    {
        mode = "n";
        key = "n";
        action = "nzzzv";
    }
    {
        mode = "n";
        key = "N";
        action = "Nzzzv";
    }

    # selects merge changes from left (local) or right (origin) view
    {
        mode = "n";
        key = "gf";
        action = "<cmd>diffget //2<CR>";
    }
    {
        mode = "n";
        key = "gh";
        action = "<cmd>diffget //3<CR>";
    }
]
