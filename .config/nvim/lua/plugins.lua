local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    profile = {
        enable = true,
        threshold = 0.0001,
    },
    git = {
        clone_timeout = 300,
        subcommands = {
            update = "pull --rebase",
        },
    },
    auto_clean = true,
    compile_on_sync = true,
})

return packer.startup(function(use)
    use("wbthomason/packer.nvim")

    -- Performance
    use("lewis6991/impatient.nvim")
    use("antoinemadec/FixCursorHold.nvim")

    -- Misc
    use("nvim-lualine/lualine.nvim")
    use("nvim-lua/plenary.nvim")
    use("moll/vim-bbye")
    use("folke/which-key.nvim")
    use("mrjones2014/smart-splits.nvim")
    use("nvim-telescope/telescope.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use("nvim-telescope/telescope-file-browser.nvim")
    use("nvim-telescope/telescope-dap.nvim")
    use("lukas-reineke/indent-blankline.nvim")
    use("kyazdani42/nvim-tree.lua")
    use("kyazdani42/nvim-web-devicons")
    use("akinsho/bufferline.nvim")
    use("akinsho/toggleterm.nvim")
    use("goolord/alpha-nvim")
    use("ggandor/leap.nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("dstein64/vim-startuptime")
    use("McAuleyPenney/tidy.nvim")
    use("lewis6991/gitsigns.nvim")
    use("numToStr/Comment.nvim")
    use("windwp/nvim-autopairs")
    use("stevearc/dressing.nvim")
    use("MunifTanjim/nui.nvim")
    use("max397574/better-escape.nvim")
    use("kylechui/nvim-surround")
    use("Pocco81/true-zen.nvim")
    use("rcarriga/nvim-notify")
    use("ahmedkhalf/project.nvim")

    -- Colorschemes
    use({ "catppuccin/nvim", run = ":CatppuccinCompile" })

    -- LSP
    use("neovim/nvim-lspconfig")
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-nvim-lsp")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("rafamadriz/friendly-snippets")
    use("onsails/lspkind-nvim")
    use("folke/trouble.nvim")
    use("simrat39/symbols-outline.nvim")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")
    use({
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
    })
    use({
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
    })
    use("theHamsta/nvim-semantic-tokens")

    if packer_bootstrap then
        require('packer').sync()
    end

end)
