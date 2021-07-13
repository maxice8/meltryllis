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

	use { -- Make the background of a string representing a color with the color it represents
		'norcalli/nvim-colorizer.lua',
		config = function()
			require('colorizer').setup{
				'*', -- highlight all filetypes
			}
		end
	}

    use { -- Linting and Fixing of source code
        'dense-analysis/ale',
        ft = {'sh', 'bash', 'markdown', 'apkbuild', 'vim', 'cpp', 'lua', 'go'},
        cmd = 'ALEEnable',
        setup = function() 
			vim.g.ale_completion_enabled = false
			vim.g.ale_fix_on_save = true
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
    use "rafamadriz/friendly-snippets" -- Some nice snippets
	use "hrsh7th/vim-vsnip" -- Snippets framework

	use { -- Colorscheme
		'sainnhe/gruvbox-material',
		requires = { 'rktjmp/lush.nvim' },
		config = function()
			vim.o.termguicolors = true
			vim.g.gruvbox_material_background = 'hard'
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_enable_bold = false
			vim.g.gruvbox_material_better_performance = true
			vim.g.gruvbox_material_palette = 'material'
			vim.cmd[[colorscheme gruvbox-material]]
		end
	}

	use { -- Autopairing support
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
			require("nvim-autopairs.completion.compe").setup({
				map_cr = true, -- map <CR> on insert mode
				map_complete = true -- it will auto insert `(` after select function or method buffer
			})
		end
	}

	use { -- Nice bar
  		'hoob3rt/lualine.nvim',
		after = 'gruvbox-material',
  		requires = {'kyazdani42/nvim-web-devicons', opt = true},
		config = function()
			require('lualine').setup{
				options = {
					icons_enabled = false,
					theme = 'gruvbox_material',
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'branch'},
					lualine_c = {
						'filename',
						{
							'diagnostics',
							sources = { 'nvim_lsp', 'ale' }, -- Only 2 sources we use
						}
					},
					lualine_x = {'encoding', 'fileformat', 'filetype'},
					lualine_y = {'diff', 'progress'},
					lualine_z = {'location'}
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {'filename'},
					lualine_x = {'location'},
					lualine_y = {},
					lualine_z = {}
				},
				tabline = {}
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
		'neovim/nvim-lspconfig',
		config = function()
			local golang_setup = {
				on_attach = function(client, bufnr)
					require('lsp_signature').on_attach({
						bind = true,
						handler_opts = {
							border = "single"
						}
					})
				end,
			}
			require('lspconfig').gopls.setup(golang_setup)
		end
	}

	use { -- Show signature of a function as you write its arguments
		'ray-x/lsp_signature.nvim'
	}
end)
