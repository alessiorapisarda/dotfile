return {
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = {},
        config = function(_, opts)
            require("copilot").setup(opts)
        end,
        dependencies = {
            "zbirenbaum/copilot-cmp",
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        opts = {},
        config = function(_, opts)
            require("copilot_cmp").setup(opts)
        end,
    },
}
