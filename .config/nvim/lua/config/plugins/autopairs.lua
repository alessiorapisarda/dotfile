local M = {
    "windwp/nvim-autopairs",
    event = "BufReadPost",
}

function M.config()
    local autopairs_status_ok, autopairs = pcall(require, "nvim-autopairs")
    if not autopairs_status_ok then
        return
    end

    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
        return
    end

    autopairs.setup({
        check_ts = true,
        enable_check_bracket_line = false,
        disable_filetype = { "TelescopePrompt" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "Search",
            highlight_grey = "Comment",
        },
    })

    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return M
