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
    
	use {
		'lewis6991/gitsigns.nvim',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require('gitsigns').setup{
				sign_priority = 6,
				use_decoration_api = true,
				use_internal_diff = true,
				linehl = false,
				numhl = false
			}
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

	use { -- Completion
		'hrsh7th/nvim-compe',
		config = function() 
			vim.o.completeopt = "menuone,noselect"
			require('vendor.nvim-compe')
		end -- Use the file we vendor from upstream
	}

	use "hrsh7th/vim-vsnip" -- Snippets framework

	use { -- Colorscheme
		'navarasu/onedark.nvim',
		config = function()
			vim.o.termguicolors = true
			vim.o.background = 'dark'
			vim.g.onedark_style = 'darker'
			require('onedark').setup()
		end
	}

	use { -- Nice bar
  		'hoob3rt/lualine.nvim',
  		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			require('lualine').setup{
				options = {
					icons_enabled = false,
					theme = 'onedark'
				}
			}
		end
	}

	use { -- Unified highlight for all filetypes
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup{
				ensure_installed = {
					'bash',
					'fish',
					'yaml',
					'toml',
					'python',
					'go',
					'c',
					'cpp',
					'cmake',
					'lua',
					'json'
				},
				highlight = {
					enable = true
				},
				indent = {
					enable = true
				}
			}
		end
    }

	use { -- LSP configurations for builtin LSP client
		'neovim/nvim-lspconfig'
	}
end)
