local M = {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
    build = ":CatppuccinCompile",
}

function M.config()
    local catpuccin_status_ok, catppuccin = pcall(require, "catppuccin")
    if not catpuccin_status_ok then
        return
    end

    -- Catppuccin
    catppuccin.setup({
        flavour = "mocha", -- mocha, macchiato, frappe, latte
        transparent_background = false,
        term_colors = false,
        dim_inactive = {
            enabled = false,
            shade = "dark",
            percentage = 0.15,
        },
        styles = {
            comments = { "italic" },
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
        },
        color_overrides = {},
        integrations = {
            aerial = false,
            barbar = false,
            beacon = false,
            cmp = true,
            coc_nvim = false,
            dashboard = true,
            fern = false,
            fidget = false,
            gitgutter = false,
            gitsigns = true,
            harpoon = true,
            hop = false,
            illuminate = false,
            leap = true,
            lightspeed = false,
            lsp_saga = true,
            lsp_trouble = true,
            markdown = true,
            mason = true,
            mini = false,
            neogit = false,
            neotest = false,
            neotree = false,
            noice = true,
            notify = true,
            nvimtree = true,
            overseer = true,
            pounce = false,
            semantic_tokens = true,
            symbols_outline = true,
            telekasten = false,
            telescope = true,
            treesitter = true,
            treesitter_context = true,
            ts_rainbow = false,
            vim_sneak = false,
            vimwiki = false,
            which_key = true,
            dap = {
                enabled = true,
                enable_ui = true,
            },
            indent_blankline = {
                enabled = true,
                colored_indent_levels = false,
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
            },
            navic = {
                enabled = false,
                custom_bg = "NONE",
            },
        },
    })

    vim.api.nvim_command("colorscheme catppuccin")
end

return M
