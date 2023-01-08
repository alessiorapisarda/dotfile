return {
	-- Misc
	{ "stevearc/dressing.nvim", event = "VeryLazy" },
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	{ "moll/vim-bbye", cmd = { "Bdelete" } },
	{ "andweeb/presence.nvim", event = "BufReadPost" },
	{ "McAuleyPenney/tidy.nvim", event = "BufReadPost" },
	{ "tpope/vim-repeat", event = "BufReadPost" },
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
	{ "rcarriga/nvim-notify", event = "VimEnter" },
	{
		"jackMort/ChatGPT.nvim",
		event = "BufReadPost",
		config = function()
			require("chatgpt").setup({
				-- optional configuration
			})
		end,
	},
}
