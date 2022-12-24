local M = {
    "stevearc/overseer.nvim",
}

function M.config()
    local overseer_status_ok, overseer = pcall(require, "overseer")
    if not overseer_status_ok then
        return
    end

    overseer.setup()
end

return M
