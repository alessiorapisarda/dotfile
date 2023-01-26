return {
    {
        "mrjones2014/smart-splits.nvim",
        keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "C-Up", "C-Down", "C-Left", "C-Right" },
        config = function()
            local smart_splits = require("smart-splits")
            local set = vim.keymap.set

            -- Better window navigation
            set("n", "<C-h>", function()
                smart_splits.move_cursor_left()
            end)
            set("n", "<C-j>", function()
                smart_splits.move_cursor_down()
            end)
            set("n", "<C-k>", function()
                smart_splits.move_cursor_up()
            end)
            set("n", "<C-l>", function()
                smart_splits.move_cursor_right()
            end)

            -- Resize with arrows
            set("n", "<C-Up>", function()
                smart_splits.resize_up()
            end)
            set("n", "<C-Down>", function()
                smart_splits.resize_down()
            end)
            set("n", "<C-Left>", function()
                smart_splits.resize_left()
            end)
            set("n", "<C-Right>", function()
                smart_splits.resize_right()
            end)
        end,
    },
}
