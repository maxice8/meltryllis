-- Helper function to set keymaps
local opts = { noremap = false, silent = true }

-- Fast save and exit
vim.api.nvim_set_keymap('', 'x', ':write!<cr>:quit<cr>', opts)

-- Fast save
vim.api.nvim_set_keymap('', '<Enter>', ':w<cr>', opts)

-- Fast exit
vim.api.nvim_set_keymap('', 'q', ':quit<cr>', opts)

-- Toggle paste mode on and off
vim.api.nvim_set_keymap('', '<Leader>p', ':setlocal paste!<cr>', opts)
