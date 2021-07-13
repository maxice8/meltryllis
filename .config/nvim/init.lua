-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

-- Set a sane leader here
vim.g.mapleader = ' '

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
[[
augroup Packer
autocmd!
autocmd BufWritePost init.lua PackerCompile
augroup end
]], false)

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
    use {
		'airblade/vim-gitgutter',
		setup = function()
			vim.g.gitgutter_realtime = 1
			vim.g.gitgutter_eager = 0
			vim.g.gitgutter_override_sign_column_highlight = 0
		end
	}
    
    use {
        'dense-analysis/ale',
        ft = {'sh', 'bash', 'markdown', 'apkbuild', 'vim', 'cpp', 'lua', 'go'},
        cmd = 'ALEEnable',
        setup = function() 
			vim.g.ale_completion_enabled = 1
			vim.g.ale_linters = {
				['apkbuild'] = {'apkbuild_lint', 'secfixes_check'}
			}
		end,
		config = function()
			vim.cmd[[ALEEnable]]
		end
    }

	-- Completion
	use {
		'hrsh7th/nvim-compe',
		setup = function() require('vendor.nvim-compe') end -- Use the file we vendor from upstream
	}

	-- Colorscheme
	use {
		'npxbr/gruvbox.nvim',
		requires = { 'rktjmp/lush.nvim' },
		setup = function()
			vim.o.termguicolors = true
			vim.o.background = 'dark'
			vim.g.gruvbox_italic = true
			vim.g.gruvbox_contrast_dark = 'hard'
		end,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end
	}

	-- Lualine
	use {
  		'hoob3rt/lualine.nvim',
  		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		setup = function()
			require('lualine').setup{
				options = {
					icons_enabled = false,
					theme = 'gruvbox'
				}
			}
		end
	}

	-- Highlight, edit, and navigate code using a fast incremental parsing library
	use { 
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		setup = function()
			require('nvim-treesitter.configs').setup {
				indent = {
					enable = true,
				},
				highlight = {
					enable = true,
				}
			}
		end
	}
	-- Additional textobjects for treesitter
	use 'nvim-treesitter/nvim-treesitter-textobjects'
end)

-- Sensible defaults
require('settings')

-- Keymaps
require('keymaps')
