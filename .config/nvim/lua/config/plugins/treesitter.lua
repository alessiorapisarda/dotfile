local M = {
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", event = "BufReadPre" },
	{ "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
	{ "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
	{ "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre" },
	{ "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
	{
		"mfussenegger/nvim-treehopper",
		keys = { { "m", mode = { "o", "x" } } },
		config = function()
			vim.cmd([[
        omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
        xnoremap <silent> m :lua require('tsht').nodes()<CR>
      ]])
		end,
	},
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = "all",
		sync_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				scope_incremental = "<C-s>",
				node_decremental = "<C-bs>",
			},
		},
		indent = {
			enable = true,
		},
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
		autopairs = {
			enable = true,
		},
		textsubjects = {
			enable = true,
			prev_selection = ",",
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
				["i;"] = "textsubjects-container-inner",
			},
		},
	})

	require("treesitter-context").setup({})
end

return M
