local M = {
	"EtiamNullam/deferred-clipboard.nvim",
}

function M.config()
	local deferred_clipboard_status_ok, deferred_clipboard = pcall(require, "deferred-clipboard")
	if not deferred_clipboard_status_ok then
		return
	end

	deferred_clipboard.setup()({
		lazy = true,
	})
end

return M
