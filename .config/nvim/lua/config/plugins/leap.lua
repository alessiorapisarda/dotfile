return {
    {
        "ggandor/leap.nvim",
        keys = { "s", "S" },
        opts = {},
        config = function(_, opts)
            require("leap").setup(opts)
            require("leap").add_default_mappings()
            require("flit").setup()
        end,
        dependencies = {
            { "ggandor/flit.nvim" },
            { "ggandor/leap-ast.nvim" },
        },
    },
}
