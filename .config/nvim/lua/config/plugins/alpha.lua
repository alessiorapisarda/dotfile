return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        opts = function()
            local dashboard = require("alpha.themes.dashboard")
            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }

            dashboard.section.buttons.val = {
                dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button(
                    "f",
                    "  Find file",
                    ":Telescope find_files find_command=rg,--files,--follow prompt_prefix=🔍<CR>"
                ),
                dashboard.button("u", "  Recently used files", ":Telescope oldfiles <CR>"),
                dashboard.button(
                    "p",
                    " " .. " Find project",
                    ":lua require('telescope').extensions.projects.projects()<CR>"
                ),
                dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
                dashboard.button("m", "  Marks", ":Telescope marks <CR>"),
                --  dashboard.button("r", "®  Registers", ":Telescope registers <CR>"),
                dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
            }
            return dashboard
        end,
        config = function(_, dashboard)
            require("alpha").setup(dashboard.opts)
        end,
    },
}
