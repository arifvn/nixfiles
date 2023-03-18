local map = vim.keymap.set
local opt = { noremap = true, silent = true }
local opt2 = { noremap = true, silent = true, expr = true }
local opt3 = { expr = true, silent = true }

-- set leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- ---------------------------------------------------
-- General Keymaps
-- ---------------------------------------------------

-- clear search highlights
map('n', '<Esc>', [[{-> v:hlsearch ? ":nohl<CR>" : "<Esc>"}()]], opt2)

-- save file
map({ 'i', 'v', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' }, opt)

-- add these 3 characters to undo break-points
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- delete single character without copying into register
map('n', 'x', '"_x')

-- select from current cursor position
-- till the last character of the line excluding trailing whitespace
map('n', '<S-E>', 'vg_', opt)
map('n', ')', 'vg0', opt)

-- window management
map('n', '<leader>sv', '<C-w>v', opt) -- split window vertically
map('n', '<leader>se', '<C-w>=', opt) -- make split windows equal width & height
map('n', '<leader>sh', '<C-w>s', opt) -- split window horizontally
map('n', '<leader>sx', '<cmd>close<CR>', opt) -- close current split window

map('n', '<leader>w', '<cmd>w<CR>', opt) -- save current buffer
map('n', '<leader>q', '<cmd>q!<CR>', opt) -- close current buffer

-- Remap for dealing with word wrap
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", opt3)
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", opt3)

-- Select all
map('n', 'ya', 'gg<S-v>G', opt)

-- unlimited paste
map('x', 'p', [["_dP]], opt)

-- toggle wrap
map('n', '<leader>r', '<cmd>set wrap!<cr>', opt)

-- move line in selection mode
map('v', 'J', ":m '>+1<CR>gv=gv", opt)
map('v', 'K', ":m '<-2<CR>gv=gv", opt)

-- replace the same words simultaneously
map('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opt)

-- insert a blank line below and above current line
map('n', 'zj', 'o<ESC>k', opt)
map('n', 'zk', 'O<ESC>j', opt)

-- Keymaps for better default experience
map({ 'n', 'v' }, '<Space>', '<Nop>', opt)

-- Stay in indent mode
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)
