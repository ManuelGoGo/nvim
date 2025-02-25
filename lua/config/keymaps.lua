local map = vim.keymap
map.set('n', '<c-k>', ':wincmd k<CR>')
map.set('n', '<c-j>', ':wincmd j<CR>')
map.set('n', '<c-h>', ':wincmd h<CR>')
map.set('n', '<c-l>', ':wincmd l<CR>')

map.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true
