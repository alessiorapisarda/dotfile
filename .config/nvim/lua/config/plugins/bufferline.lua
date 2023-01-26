return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        init = function()
            vim.keymap.set("n", "<s-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
            vim.keymap.set("n", "<s-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
        end,
        opts = {
            options = {
                mode = "buffers",
                numbers = "none",
                close_command = "Bdelete! %d",
                right_mouse_command = "Bdelete! %d",
                left_mouse_command = "buffer %d",
                middle_mouse_command = nil,
                indicator = {
                    icon = "▎",
                    style = "icon",
                },
                buffer_close_icon = "",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                max_name_length = 14,
                max_prefix_length = 13,
                tab_size = 20,
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = false,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "NvimTree",
                        padding = 0,
                    },
                    {
                        filetype = "neo-tree",
                        text = "neo-tree",
                        padding = 0,
                    },
                    { filetype = "Outline", text = "", padding = 1 },
                },
                color_icons = true,
                show_buffer_icons = true,
                show_buffer_close_icons = true,
                show_buffer_default_icon = true,
                show_close_icon = false,
                show_tab_indicators = true,
                persist_buffer_sort = true,
                separator_style = "thick",
                enforce_regular_tabs = true,
                always_show_bufferline = false,
            },
        },
    },
}
