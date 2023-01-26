return {
    {
        "m4xshen/autoclose.nvim",
        event = "InsertEnter",
        opts = {},
        config = function(_, opts)
            require("autoclose").setup(opts)
        end,
    },
}
