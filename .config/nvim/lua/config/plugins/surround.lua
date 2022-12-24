local M = {
    "kylechui/nvim-surround",
    event = "BufReadPre",
}

function M.config()
    local surround_status_ok, surround = pcall(require, "nvim-surround")
    if not surround_status_ok then
        return
    end

    surround.setup()
end

return M
