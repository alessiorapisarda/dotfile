return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    opts = { theme = "wave" },
    config = function()
      require("kanagawa").setup({
        colors = {
          palette = {
            sumiInk0 = "#080810", -- Lazy Popup
            sumiInk1 = "#101020", -- Telescope preview            NeoTreeNormal = { bg = colors.palette.sumiInk1 },
            sumiInk2 = "#121220", -- ?
            sumiInk3 = "#161620", -- background
            sumiInk4 = "#141420", -- status bar, line bar and sitter
            fujiWhite = "#FFFFFF", -- White text
          },
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
              },
            },
          },
        },

        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            NeoTreeNormal = { bg = colors.palette.sumiInk4 },
            NeoTreeNormalNC = { bg = colors.palette.sumiInk4 },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim, fg = colors.palette.fujiWhite },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            TelescopeTitle = { fg = theme.ui.special, bold = true },
            TelescopePromptNormal = { bg = theme.ui.bg_p1 },
            TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
            TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
            TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
            TelescopePreviewNormal = { bg = theme.ui.bg_dim },
            TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

            Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
