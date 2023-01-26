return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        opts = {
            buftype_exclude = {
                "nofile",
                "terminal",
            },
            filetype_exclude = {
                "help",
                "startify",
                "aerial",
                "alpha",
                "dashboard",
                "packer",
                "neogitstatus",
                "NvimTree",
                "Trouble",
            },
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = false,
            show_trailing_blankline_indent = false,
            use_treesitter = true,
        },
        config = function(_, opts)
            vim.opt.list = true
            vim.opt.listchars:append("space:⋅")
            vim.opt.listchars:append("eol:↴")

            require("indent_blankline").setup(opts)
        end,
    },
}
