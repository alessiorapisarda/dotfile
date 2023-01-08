local M = {
	"mrjones2014/smart-splits.nvim",
	keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "C-Up", "C-Down", "C-Left", "C-Right" },
}

function M.config()
	local smart_splits_status_ok, smart_splits = pcall(require, "smart-splits")
	if not smart_splits_status_ok then
		return
	end

	-- Better window navigation
	vim.keymap.set("n", "<C-h>", function()
		smart_splits.move_cursor_left()
	end)
	vim.keymap.set("n", "<C-j>", function()
		smart_splits.move_cursor_down()
	end)
	vim.keymap.set("n", "<C-k>", function()
		smart_splits.move_cursor_up()
	end)
	vim.keymap.set("n", "<C-l>", function()
		smart_splits.move_cursor_right()
	end)

	-- Resize with arrows
	vim.keymap.set("n", "<C-Up>", function()
		smart_splits.resize_up()
	end)
	vim.keymap.set("n", "<C-Down>", function()
		smart_splits.resize_down()
	end)
	vim.keymap.set("n", "<C-Left>", function()
		smart_splits.resize_left()
	end)
	vim.keymap.set("n", "<C-Right>", function()
		smart_splits.resize_right()
	end)
end

return M
