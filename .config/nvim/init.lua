-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
    -- Support for scdoc, used to write manapges
    use {
        'gpanders/vim-scdoc',
        ft = {'scdoc'}
    }

    -- It is not on GitHub so we need full path, also there is no 'for'
    -- because it is the ftype required
    use {
        'https://gitlab.alpinelinux.org/Leo/apkbuild.vim.git',
        ft = {'apkbuild'}
    }
    
    -- Shows + - ~ signs on the left-side corner based on git differences
    use 'airblade/vim-gitgutter'
    
    use {
        'dense-analysis/ale',
        ft = {'sh', 'bash', 'markdown', 'apkbuild', 'vim', 'cpp', 'lua'},
        cmd = 'ALEEnable',
        config = 'vim.cmd[[ALEEnable]]'
    }

    use {'morhetz/gruvbox', as = 'gruvbox'}

	use 'hrsh7th/nvim-compe'

	-- Colorscheme
	use 'marko-cerovac/material.nvim'

	-- Lualine
	use {
  		'hoob3rt/lualine.nvim',
  		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}

	-- Neogit
	use { 
		'TimUntersberger/neogit',
		requires = 'nvim-lua/plenary.nvim'
	}
end)

-- Set a sane leader here
vim.g.mapleader = ' '

-- Sensible defaults
require('settings')

-- Keymaps
require('keymaps')

-- Plugins
require('plugins')
