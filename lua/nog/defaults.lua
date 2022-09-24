local api = vim.api
local g = vim.g
local opt = vim.opt
local wo = vim.wo

-- Behaviors
opt.belloff = "all" -- NO BELLS!
opt.swapfile = false -- no swap files
g.nobackup = true -- don't create backup files when overwriting
opt.hlsearch = true --Set highlight on search
opt.mouse = "a" --Enable mouse mode
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 50 --Decrease update time
opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.inccommand = "nosplit" -- preview %s commands live as I type

-- Indentation
opt.autoindent = true -- continue indentation to new line
opt.smartindent = true -- add extra indent when it makes sense
opt.smarttab = true -- <Tab> at the start of a line behaves as expected
opt.expandtab = true -- <Tab> inserts spaces
opt.shiftwidth = 2 -- >>, << shift line by 2 spaces
opt.tabstop = 2 -- <Tab> appears as 2 spaces
opt.softtabstop = 2 -- <Tab> behaves as 2 spaces when editing
opt.breakindent = true --Enable break indent

-- Colors & Look
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.signcolumn = "yes" -- Always show sign column
opt.colorcolumn = "80" -- show color column at 80 chars
opt.cursorline = true -- show line highlighted
opt.termguicolors = true -- Enable colors in terminal
opt.scrolloff = 10 -- padding between cursor and top/bottom of window
wo.wrap = false -- don't wrap
opt.list = true -- show hidden chars
opt.listchars = { -- overwrite hidden chars look
  eol = "↵",
  nbsp = "•",
  trail = "•",
  space = "•",
  tab = " ──",
  extends = "»",
  precedes = "«",
}

-- better searching
opt.path:remove "/usr/include" -- remove /usr/include
opt.path:append "**" -- add all files/folders under current folder
opt.wildignorecase = true -- ignore casing
opt.wildignore:append "**/.git/*" -- ignore .git folders

-- Better Netrw
g.netrw_banner = 0 -- Hide banner
g.netrw_browse_split = 4 -- Open in previous window
g.netrw_altv = 1 -- Open with right splitting
g.netrw_liststyle = 3 -- Tree-style view
g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]] -- use .gitignore

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

vim.opt.guifont = { "FantasqueSansMono Nerd Font Mono", "h12" }

vim.cmd [[
  set autoread
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  autocmd FileChangedShellPost *
    \ lua require('nog.utils').info("Detected file change, reloading...", "Autocmd")
]]
