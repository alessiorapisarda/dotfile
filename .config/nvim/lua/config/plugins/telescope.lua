return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        keys = {
            { "<leader>tf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>t/", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
            { "<leader>tg", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find in Buffer" },
            { "<leader>t:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
            { "<leader>to", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
            { "<leader>tu", "<cmd>Telescope undo<cr>", desc = "Undo History" },
            { "<leader>tb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
            { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
            { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
            { "<leader>tc", "<cmd>Telescope commands<cr>", desc = "Commands" },
            { "<leader>tm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
            { "<leader>th", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
            { "<leader>tk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
            { "<leader>ta", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
            { "<leader>tm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
            { "<leader>tr", "<cmd>Telescope registers<cr>", desc = "Registers" },
            { "<leader>tz", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
        },
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    prompt_prefix = " ",
                    selection_caret = "❯ ",
                    path_display = { "smart" },
                    selection_strategy = "reset",
                    sorting_strategy = "ascending",
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                            results_width = 0.8,
                        },
                        vertical = {
                            mirror = false,
                        },
                        width = 0.75,
                        height = 0.75,
                        preview_cutoff = 120,
                    },
                    mappings = {
                        i = {
                            ["<Down>"] = actions.cycle_history_next,
                            ["<Up>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-x>"] = actions.select_horizontal,
                            ["<C-z>"] = actions.select_vertical,
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            local telescope = require("telescope")
            telescope.load_extension("file_browser")
            telescope.load_extension("dap")
            telescope.load_extension("projects")
            telescope.load_extension("undo")
            telescope.load_extension("fzf")

            telescope.setup(opts)
        end,
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            { "nvim-telescope/telescope-file-browser.nvim" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "nvim-telescope/telescope-project.nvim" },
            { "debugloop/telescope-undo.nvim" },
        },
    },
}
