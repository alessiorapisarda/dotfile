local set = vim.opt
set.fileencoding = "utf-8"
set.incsearch = true
set.hlsearch = true
set.ignorecase = true
set.smartcase = true
set.number = true
set.relativenumber = false
set.hidden = true
set.cursorline = true
set.confirm = true
set.showmode = false
set.showcmd = true
set.cmdheight = 1
set.laststatus = 3
set.timeoutlen = 300
set.updatetime = 250
set.scrolloff = 8
set.sidescrolloff = 8
set.mouse = "a"
set.clipboard = "unnamedplus"
set.swapfile = false
set.undofile = true
set.backup = false
set.writebackup = false
set.conceallevel = 0
set.wrap = false
set.splitbelow = true
set.splitright = true
set.wrap = false
set.termguicolors = true
set.completeopt = { "menuone", "noselect" }
set.signcolumn = "yes"
set.smartindent = true
set.expandtab = true
set.shiftwidth = 4

-- don't load the plugins below
local builtins = {
    "gzip",
    "zip",
    "zipPlugin",
    "fzf",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "matchit",
    "matchparen",
    "logiPat",
    "rrhelper",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
}

for _, plugin in ipairs(builtins) do
    vim.g["loaded_" .. plugin] = 1
end
