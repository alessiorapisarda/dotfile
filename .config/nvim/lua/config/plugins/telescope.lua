local M = {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	dependencies = {
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-dap.nvim" },
		{ "nvim-telescope/telescope-project.nvim" },
		{ "debugloop/telescope-undo.nvim" },
	},
}

function M.config()
	local telescope_status_ok, telescope = pcall(require, "telescope")
	if not telescope_status_ok then
		return
	end

	local actions = require("telescope.actions")

	telescope.setup({
		extensions = {
			-- fzf = {
			--   fuzzy = true, -- false will only do exact matching
			--   override_generic_sorter = true, -- override the generic sorter
			--   override_file_sorter = true, -- override the file sorter
			--   case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			--   -- the default case_mode is "smart_case"
			-- },
		},
		defaults = {
			prompt_prefix = " ",
			selection_caret = "❯ ",
			path_display = { "smart" },
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.75,
				height = 0.75,
				preview_cutoff = 120,
			},
			mappings = {
				i = {
					["<Down>"] = actions.cycle_history_next,
					["<Up>"] = actions.cycle_history_prev,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-x>"] = actions.select_horizontal,
					["<C-z>"] = actions.select_vertical,
				},
			},
		},
	})

	telescope.load_extension("file_browser")
	telescope.load_extension("dap")
	telescope.load_extension("projects")
	telescope.load_extension("undo")
	telescope.load_extension("fzf")
end

return M
