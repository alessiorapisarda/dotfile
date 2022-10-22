---@diagnostic disable: need-check-nil
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

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-1),
        ["<C-f>"] = cmp.mapping.scroll_docs(1),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif luasnip.jumpable(1) then
                luasnip.jump(1)
            elseif has_words_before() then
                --[[ cmp.complete() ]]
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
        { name = "buffer" },
        { name = "calc" },
        { name = "path" },
        { name = "luasnip" }, -- For luasnip users.
        { name = "copilot",
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
    }),
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            with_text = true, -- show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            menu = {
                buffer = "[Buffer]",
                buffer_lines = "[Buffer-Lines]",
                nvim_lsp = "[LSP]",
                luasnip = "[LuaSnip]",
                calc = "[Calc]",
                emoji = "[Emoji]",
                path = "[Path]",
                copilot = "[Copilot]"
            },
        }),
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = false,
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    cmdline = {
        enable = true,
        options = {
            {
                type = ":",
                sources = {
                    { name = "path" },
                },
            },
            {
                type = { "/", "?" },
                sources = {
                    { name = "buffer" },
                },
            },
        },
    },
    enabled = function()
        if vim.bo.buftype == 'prompt' then
            return false
        end
        -- disable completion in comments
        local context = require 'cmp.config.context'
        -- keep command mode completion enabled when cursor is in a comment
        if vim.api.nvim_get_mode().mode == 'c' then
            return true
        else
            return not context.in_treesitter_capture("comment")
                and not context.in_syntax_group("Comment")
        end
    end
})
