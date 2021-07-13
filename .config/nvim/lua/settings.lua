-- Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.material_style = 'darker'
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = false
require('material').set()

-- Automatically read the file when it is changed from the outside
vim.o.autoread = true
-- Sets how many lines of history NEOVIM has to remember
vim.o.history = 20
-- Clipboard
vim.o.clipboard = vim.o.clipboard .. 'unnamedplus'

-- Use cursor from the terminal
vim.g.guicursor = ''

-- doing vim.o.tabstop does not work. tabstop only works as a buffer option when
-- trying to set with meta accessors ideally, i guess they should be set per buffer
-- depending on the type of file
-- vim.cmd [[set tabstop=4]]
-- vim.cmd [[set shiftwidth=4]]
-- vim.cmd [[set smarttab]]
-- vim.cmd [[autocmd FileType javascript setlocal ts=4 sts=4 sw=4]]
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
-- don't want case sensitive searches
vim.o.ignorecase = true
-- but still want search to be smart. If i type a upper case thing, do a case
-- sensitive search
vim.o.smartcase = true
-- Use the cursor from the terminal
vim.o.guicursor = ''

-- relative line numbering, yo
-- number and relativenumber are window options. So doing vim.o.relativenumber = true
-- will not work
vim.wo.relativenumber = true
-- but we don't want pure relative line numbering. The line where the cursor is
-- should show absolute line number
vim.wo.number = true

if (vim.fn.executable('rg') ~= 0) then
	vim.g.grepprg = 'rg --vimgrep --no-heading'
	vim.g.grepformat = '%f:%l:%c:%m,%f:%l:%m'
end

vim.g.is_posix = 1

-- highlight yanked stuff. Done with native neovim api. No plugin.
-- augroup command didn't work with vim.cmd.
-- TODO: Find the difference between vim.api.nvim_command (alias vim.cmd)
-- and vim.api.nvim_exec
vim.api.nvim_exec(
[[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
]], false)

-- Return to last edit position when opening files (You want this!)
vim.api.nvim_exec(
[[
augroup reopen
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]], false) 
