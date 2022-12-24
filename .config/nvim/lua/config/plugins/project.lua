local M = {
    "ahmedkhalf/project.nvim",
}

function M.config()
    local project_status_ok, project = pcall(require, "project-nvim")
    if not project_status_ok then
        return
    end

    project.setup()
end

return M
