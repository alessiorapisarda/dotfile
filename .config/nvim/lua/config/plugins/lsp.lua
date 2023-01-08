local M = {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"theHamsta/nvim-semantic-tokens",
	},
}

function M.config()
	local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
	if not lspconfig_status_ok then
		return
	end

	local mason_status_ok, mason = pcall(require, "mason")
	if not mason_status_ok then
		return
	end

	local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
	if not mason_lspconfig_status_ok then
		return
	end

	local semantic_tokens_status_ok, semantic_tokens = pcall(require, "nvim-semantic-tokens")
	if not semantic_tokens_status_ok then
		return
	end

	vim.diagnostic.config({
		virtual_text = true,
		virtual_lines = false,
		update_in_insert = false,
		severity_sort = true,
		float = {
			focusable = true,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
	})

	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	-- Experimental
	semantic_tokens.setup({
		preset = "default",
		-- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
		-- function with the signature: highlight_token(ctx, token, highlight) where
		--        ctx (as defined in :h lsp-handler)
		--        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
		--        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
		highlighters = { require("nvim-semantic-tokens.table-highlighter") },
	})

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		local opts = { noremap = true, silent = true }
		local keymap = vim.api.nvim_buf_set_keymap
		keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
		keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
		keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
		keymap(bufnr, "n", "]d", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
		keymap(bufnr, "n", "[d", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
		keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
		keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
		keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
		keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{ async = true }<cr>", opts)
		keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
		keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

		-- Semantic Tokens
		local caps = client.server_capabilities
		if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
			local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
			vim.api.nvim_create_autocmd("TextChanged", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.semantic_tokens_full()
				end,
			})
			-- fire it first time on load as well
			vim.lsp.buf.semantic_tokens_full()
		end
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	mason.setup()
	mason_lspconfig.setup()
	mason_lspconfig.setup_handlers({
		function(server_name)
			lspconfig[server_name].setup({
				on_attach = on_attach,
				capabilities = capabilities,
			})
		end,

		["sumneko_lua"] = function()
			lspconfig.sumneko_lua.setup({
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = {
								"vim",
							},
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
						},
						-- Do not send telemetry data containing a randomized but unique identifier
						telemetry = {
							enable = false,
						},
					},
				},
			})
		end,
	})
end

return M
