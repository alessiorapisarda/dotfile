return {
    {
        "max397574/better-escape.nvim",
        event = "BufReadPost",
        opts = {},
        config = function(_, opts)
            require("better_escape").setup(opts)
        end,
    },
}
