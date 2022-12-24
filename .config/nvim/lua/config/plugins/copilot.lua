local M = {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    dependencies = {
        "zbirenbaum/copilot-cmp",
    },
}

function M.config()
    local copilot_status_ok, copilot = pcall(require, "copilot")
    if not copilot_status_ok then
        return
    end

    local copilot_cmp_status_ok, copilot_cmp = pcall(require, "copilot_cmp")
    if not copilot_cmp_status_ok then
        return
    end

    copilot.setup()
    copilot_cmp.setup()
end

return M
