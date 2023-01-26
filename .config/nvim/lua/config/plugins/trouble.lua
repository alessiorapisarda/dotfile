return {
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle" },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
        },
        opts = {
            use_diagnostic_signs = true,
        },
        config = function(_, opts)
            require("trouble").setup(opts)
        end,
    },
}
