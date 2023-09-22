local opt = vim.opt
local g = vim.g

-------------------------------------- globals -----------------------------------------
g.transparency = true
g.mapleader = " "
-------------------------------------- options -----------------------------------------
opt.laststatus = 3
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftround = true -- Round indent

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 4
opt.relativenumber = true -- Relative line numbers
opt.ruler = false

-- disble somem vim messages
opt.shortmess:append({ I = true, s = true })

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true
opt.swapfile = false

opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

-- disable some default providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
    g["loaded_" .. provider .. "_provider"] = 0
end

-- This file is automatically loaded by plugins.config

vim.g.loaded_netrwPlugin = 3
vim.g.loaded_netrw = 3

opt.hlsearch = false
opt.incsearch = true

opt.completeopt = "menu,menuone,noselect"

opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit" -- preview incremental substitute
opt.list = true -- Show some invisible characters (tabs...

opt.pumblend = 12 -- Popup blend
opt.pumheight = 12 -- Maximum number of entries in a popup
opt.scrolloff = 8 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.sidescrolloff = 8 -- Columns of context
opt.spelllang = { "en" }
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 7 -- Minimum window width
opt.wrap = false -- Disable line wrap


if vim.fn.has("nvim-0.9.0") == 1 then
    opt.splitkeep = "screen"
    opt.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
