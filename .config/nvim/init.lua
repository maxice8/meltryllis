-- Set a sane leader here
vim.g.mapleader = ' '

-- Sensible defaults
require('settings')

-- Keymaps
require('keymaps')

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
]], false)

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
local use = packer.use
packer.startup(function()
	-- Packer itself
	use 'wbthomason/packer.nvim'

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
		config = function() require('vendor.nvim-compe') end -- Use the file we vendor from upstream
	}

	-- Colorscheme
	use {
		'sainnhe/gruvbox-material',
		setup = function()
			vim.o.termguicolors = true
			vim.o.background = 'dark'
			vim.g.gruvbox_material_palette = 'material'
			vim.g.gruvbox_material_background = 'hard'
			vim.g.gruvbox_material_enable_italic = true
		end,
		config = function()
			vim.cmd([[colorscheme gruvbox-material]])
		end
	}

	-- Lualine
	use {
  		'hoob3rt/lualine.nvim',
  		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			require('lualine').setup{
				options = {
					icons_enabled = false,
					theme = 'gruvbox'
				}
			}
		end
	}
end)
