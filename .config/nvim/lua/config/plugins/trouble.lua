local M = {
	"folke/trouble.nvim",
	cmd = { "TroubleToggle" },
}

function M.config()
	local trouble_status_ok, trouble = pcall(require, "trouble")
	if not trouble_status_ok then
		return
	end

	trouble.setup({})
end

return M
