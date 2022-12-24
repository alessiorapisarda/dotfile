return {
    -- Misc
    { "stevearc/dressing.nvim", event = "VeryLazy" },
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    { "moll/vim-bbye", lazy = false },
    { "McAuleyPenney/tidy.nvim", event = "BufReadPost" },
    { "tpope/vim-repeat", event = "BufReadPost" },
    --[[ "kyazdani42/nvim-web-devicons", ]]
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        config = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        config = function()
            require("treesitter-context").setup()
        end,
    },
    { "rcarriga/nvim-notify", event = "VimEnter" },
}
