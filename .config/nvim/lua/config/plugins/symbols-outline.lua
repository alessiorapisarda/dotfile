local M = {
    "simrat39/symbols-outline.nvim",
    event = "BufReadPost",
}

function M.config()
    local symbols_outline_status_ok, symbols_outline = pcall(require, "symbols-outline")
    if not symbols_outline_status_ok then
        return
    end

    symbols_outline.setup()
end

return M
