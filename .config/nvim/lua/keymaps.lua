-- Helper function to set keymaps
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<Leader>s', 'update<cr>', opts)
vim.api.nvim_set_keymap('n', '<Leader>x', ':w<cr>quit<cr>', opts)

-- Fast save
vim.api.nvim_set_keymap('', '<Enter>', ':w<cr>', opts)

-- Toggle paste mode on and off
vim.api.nvim_set_keymap('', '<Leader>p', ':setlocal paste!<cr>', opts)

-- Open Neogit
vim.api.nvim_set_keymap('n', '<Leader>g', ':Neogit<cr>', opts)
