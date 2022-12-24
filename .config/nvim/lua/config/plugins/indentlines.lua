local M = {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
}

function M.config()
    local status_ok, indent_blankline = pcall(require, "indent_blankline")
    if not status_ok then
        return
    end

    vim.opt.list = true
    vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")

    indent_blankline.setup({
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
    })
end

return M
