---@diagnostic disable: need-check-nil
local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-calc",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"ray-x/cmp-treesitter",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind-nvim",
	},
}

function M.config()
	local cmp_status_ok, cmp = pcall(require, "cmp")
	if not cmp_status_ok then
		return
	end

	local luasnip_status_ok, luasnip = pcall(require, "luasnip")
	if not luasnip_status_ok then
		return
	end

	local lspkind_status_ok, lspkind = pcall(require, "lspkind")
	if not lspkind_status_ok then
		return
	end

	require("luasnip/loaders/from_vscode").lazy_load()

	lspkind.init({
		symbol_map = {
			Copilot = "",
		},
	})

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	---when inside a snippet, seeks to the nearest luasnip field if possible, and checks if it is jumpable
	---@param dir number 1 for forward, -1 for backward; defaults to 1
	---@return boolean true if a jumpable luasnip field is found while inside a snippet
	local function jumpable(dir)
		local win_get_cursor = vim.api.nvim_win_get_cursor
		local get_current_buf = vim.api.nvim_get_current_buf

		---sets the current buffer's luasnip to the one nearest the cursor
		---@return boolean true if a node is found, false otherwise
		local function seek_luasnip_cursor_node()
			-- TODO(kylo252): upstream this
			-- for outdated versions of luasnip
			if not luasnip.session.current_nodes then
				return false
			end

			local node = luasnip.session.current_nodes[get_current_buf()]
			if not node then
				return false
			end

			local snippet = node.parent.snippet
			local exit_node = snippet.insert_nodes[0]

			local pos = win_get_cursor(0)
			pos[1] = pos[1] - 1

			-- exit early if we're past the exit node
			if exit_node then
				local exit_pos_end = exit_node.mark:pos_end()
				if (pos[1] > exit_pos_end[1]) or (pos[1] == exit_pos_end[1] and pos[2] > exit_pos_end[2]) then
					snippet:remove_from_jumplist()
					luasnip.session.current_nodes[get_current_buf()] = nil

					return false
				end
			end

			node = snippet.inner_first:jump_into(1, true)
			while node ~= nil and node.next ~= nil and node ~= snippet do
				local n_next = node.next
				local next_pos = n_next and n_next.mark:pos_begin()
				local candidate = n_next ~= snippet and next_pos and (pos[1] < next_pos[1])
					or (pos[1] == next_pos[1] and pos[2] < next_pos[2])

				-- Past unmarked exit node, exit early
				if n_next == nil or n_next == snippet.next then
					snippet:remove_from_jumplist()
					luasnip.session.current_nodes[get_current_buf()] = nil

					return false
				end

				if candidate then
					luasnip.session.current_nodes[get_current_buf()] = node
					return true
				end

				local ok
				ok, node = pcall(node.jump_from, node, 1, true) -- no_move until last stop
				if not ok then
					snippet:remove_from_jumplist()
					luasnip.session.current_nodes[get_current_buf()] = nil

					return false
				end
			end

			-- No candidate, but have an exit node
			if exit_node then
				-- to jump to the exit node, seek to snippet
				luasnip.session.current_nodes[get_current_buf()] = snippet
				return true
			end

			-- No exit node, exit from snippet
			snippet:remove_from_jumplist()
			luasnip.session.current_nodes[get_current_buf()] = nil
			return false
		end

		if dir == -1 then
			return luasnip.in_snippet() and luasnip.jumpable(-1)
		else
			return luasnip.in_snippet() and seek_luasnip_cursor_node() and luasnip.jumpable(1)
		end
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		confirm_opts = {
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
			["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<C-y>"] = cmp.mapping({
				i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
				c = function(fallback)
					if cmp.visible() then
						cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
					else
						fallback()
					end
				end,
			}),
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					local confirm_opts = {
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}
					local is_insert_mode = function()
						return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
					end
					if is_insert_mode() then -- prevent overwriting brackets
						confirm_opts.behavior = cmp.ConfirmBehavior.Insert
					end
					if cmp.confirm(confirm_opts) then
						return -- success, exit early
					end
				end
				fallback() -- if not exited early, always fallback
			end),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_locally_jumpable() then
					luasnip.expand_or_jump()
				elseif jumpable(1) then
					luasnip.jump(1)
				elseif has_words_before() then
					-- cmp.complete()
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lua" },
			{ name = "treesitter" },
			{ name = "luasnip" }, -- For luasnip users.
			{
				name = "copilot",
				-- keyword_length = 0,
				max_item_count = 3,
				trigger_characters = {
					{
						".",
						":",
						"(",
						"'",
						'"',
						"[",
						",",
						"#",
						"*",
						"@",
						"|",
						"=",
						"-",
						"{",
						"/",
						"\\",
						"+",
						"?",
						" ",
						-- "\t",
						-- "\n",
					},
				},
			},
			{ name = "buffer" },
			{ name = "path" },
			{ name = "calc" },
		}),
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				with_text = true, -- show text alongside icons
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lua = "[Lua]",
					treesitter = "[Treesitter]",
					luasnip = "[LuaSnip]",
					copilot = "[Copilot]",
					buffer = "[Buffer]",
					path = "[Path]",
					calc = "[Calc]",
				},
			}),
			duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 0,
				luasnip = 1,
			},
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		experimental = {
			ghost_text = false,
			native_menu = false,
		},
		enabled = function()
			local buftype = vim.api.nvim_buf_get_option(0, "buftype")
			if buftype == "prompt" then
				return false
			end
			-- disable completion in comments
			local context = require("cmp.config.context")
			-- keep command mode completion enabled when cursor is in a comment
			if vim.api.nvim_get_mode().mode == "c" then
				return true
			else
				return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
			end
		end,
	})

	cmp.setup.cmdline({ "/", "?" }, {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end

return M
