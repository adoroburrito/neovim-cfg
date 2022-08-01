local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local default_opts_remap = { noremap = false, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

vim.g.gui_font_default_size = 16
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "FantasqueSansMono Nerd Font Mono"

RefreshGuiFont = function()
  vim.opt.guifont = string.format("%s:h%s",vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
  vim.g.gui_font_size = vim.g.gui_font_size + delta
  RefreshGuiFont()
end

ResetGuiFont = function ()
  vim.g.gui_font_size = vim.g.gui_font_default_size
  RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps
keymap("n", "<C-+>", ":luado ResizeGuiFont(1)<CR>", default_opts)
keymap("n", "<C-->", ":luado ResizeGuiFont(-1)<CR>", default_opts)
keymap("n", "<C-BS>", ":luado ResizeGuiFont()<CR>", default_opts)
keymap("i", "<C-+>", ":luado ResizeGuiFont(1)<CR>", default_opts)
keymap("i", "<C-->", ":luado ResizeGuiFont(-1)<CR>", default_opts)
keymap("i", "<C-BS>", ":luado ResizeGuiFont()<CR>", default_opts)
