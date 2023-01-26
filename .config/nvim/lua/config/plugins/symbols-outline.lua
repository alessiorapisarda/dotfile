return {
    {
        "simrat39/symbols-outline.nvim",
        cmd = { "SymbolsOutline" },
        keys = {
            { "<leader>lo", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" },
        },
        opts = {},
        config = function(_, opts)
            require("symbols-outline").setup(opts)
        end,
    },
}
