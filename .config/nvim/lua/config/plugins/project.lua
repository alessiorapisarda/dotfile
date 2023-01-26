return {
    {
        "ahmedkhalf/project.nvim",
        cmd = { "Telescope projects" },
        opts = {},
        config = function(_, opts)
            require("project_nvim").setup(opts)
        end,
    },
}
