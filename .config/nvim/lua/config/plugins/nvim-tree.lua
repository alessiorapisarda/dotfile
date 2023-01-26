return {
    {
        "kyazdani42/nvim-tree.lua",
        cmd = { "NvimTreeToggle" },
        keys = {
            { "<leader><CR>", "<cmd>NvimTreeToggle<CR>", desc = "NvimTree" },
        },
        opts = {
            sort_by = "name",
            diagnostics = {
                enable = true,
                show_on_dirs = false,
            },
            update_focused_file = {
                enable = true,
                update_cwd = true,
            },
            renderer = {
                indent_markers = {
                    enable = true,
                },
            },
        },
        config = function(_, opts)
            vim.g.loaded = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup(opts)

            -- Auto-close NvimTree when no tabs open
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
                pattern = "NvimTree_*",
                callback = function()
                    local layout = vim.api.nvim_call_function("winlayout", {})
                    if
                        layout[1] == "leaf"
                        and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
                        and layout[3] == nil
                    then
                        vim.cmd("confirm quit")
                    end
                end,
            })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            event = "VeryLazy",
            config = function()
                require("nvim-web-devicons").setup({ default = true })
            end,
        },
    },
}
