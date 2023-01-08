local M = {
	"kyazdani42/nvim-tree.lua",
	cmd = { "NvimTreeToggle" },
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		event = "VeryLazy",
		config = function()
			require("nvim-web-devicons").setup({ default = true })
		end,
	},
}

function M.config()
	local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
	if not nvim_tree_status_ok then
		return
	end

	vim.g.loaded = 1
	vim.g.loaded_netrwPlugin = 1

	nvim_tree.setup({
		sort_by = "name",
		diagnostics = {
			enable = true,
			show_on_dirs = false,
		},
		update_focused_file = {
			enable = true,
			update_cwd = true,
		},
		renderer = {
			indent_markers = {
				enable = true,
			},
		},
	})

	-- Auto-close NvimTree when no tabs open
	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
		pattern = "NvimTree_*",
		callback = function()
			local layout = vim.api.nvim_call_function("winlayout", {})
			if
				layout[1] == "leaf"
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree"
				and layout[3] == nil
			then
				vim.cmd("confirm quit")
			end
		end,
	})
end

return M
