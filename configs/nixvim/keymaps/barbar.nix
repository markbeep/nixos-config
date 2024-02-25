[
    # switch tabs
    {
    mode = "n";
    key = "<A-,>";
    action = "<cmd>BufferPrevious<CR>";
    }
    {
    mode = "n";
    key = "<A-.>";
    action = "<cmd>BufferNext<CR>";
    }
    # reposition tabs
    {
    mode = "n";
    key = "<A-<>";
    action = "<cmd>BufferMovePrevious<CR>";
    }
    {
    mode = "n";
    key = "<A->>";
    action = "<cmd>BufferMoveNext<CR>";
    }
    # jump to tab
    {
    mode = "n";
    key = "<A-1>";
    action = "<cmd>BufferGoto 1<CR>";
    }
    {
    mode = "n";
    key = "<A-2>";
    action = "<cmd>BufferGoto 2<CR>";
    }
    {
    mode = "n";
    key = "<A-3>";
    action = "<cmd>BufferGoto 3<CR>";
    }
    {
    mode = "n";
    key = "<A-4>";
    action = "<cmd>BufferGoto 4<CR>";
    }
    {
    mode = "n";
    key = "<A-5>";
    action = "<cmd>BufferGoto 5<CR>";
    }
    {
    mode = "n";
    key = "<A-6>";
    action = "<cmd>BufferGoto 6<CR>";
    }
    {
    mode = "n";
    key = "<A-7>";
    action = "<cmd>BufferGoto 7<CR>";
    }
    {
    mode = "n";
    key = "<A-8>";
    action = "<cmd>BufferGoto 8<CR>";
    }
    {
    mode = "n";
    key = "<A-9>";
    action = "<cmd>BufferGoto 9<CR>";
    }
    {
    mode = "n";
    key = "<A-0>";
    action = "<cmd>BufferGoto 0<CR>";
    }
    # close
    {
    mode = "n";
    key = "<A-w>";
    action = "<cmd>BufferClose<CR>";
    }
    # force close
    {
    mode = "n";
    key = "<A-S-w>";
    action = "<cmd>BufferClose!<CR>";
    }
]
