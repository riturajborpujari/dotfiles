require("config/lazy")
require("config/color")
require("config/remap")

vim.mapleader = ' '

vim.opt.guicursor = ''
vim.opt.nu = true
vim.opt.rnu = true

vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true

vim.opt.foldenable=true
vim.opt.foldmethod="indent"
vim.opt.foldlevel=99

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.path = vim.opt.path + "src/**,app/**"
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum,fuzzy"

vim.opt.scrolloff = 8
vim.opt.signcolumn = "no"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
