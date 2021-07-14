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

local packer = require('packer')
local use = packer.use

packer.init {
	display = {
		open_fn = function()
			return require('packer.util').float {border = 'single'}
		end
	}
}

packer.startup(function()
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
		event = 'BufRead',
		requires = {
			'nvim-lua/plenary.nvim'
		},
		config = function()
			require('gitsigns').setup{
				signs = {
					add = {
						hl = 'DiffAdd',
						text = '▌',
						numhl = 'GitSignsAddNr'
					},
					change = {
						hl = 'DiffChange',
						text = '▌',
						numhl = 'GitSignsChangeNr'
					},
					delete = {
						hl = 'DiffDelete',
						text = '_',
						numhl = 'GitSignsDeleteNr'
					},
					topdelete = {
						hl = 'DiffDelete',
						text = '‾',
						numhl = 'GitSignsDeleteNr'
					},
					changedelete = {
						hl = 'DiffChange',
						text = '~',
						numhl = 'GitSignsChangeNr'
					}
				},
				numhl = false,
				watch_index = {
					interval = 100
				},
				sign_priority = 5,
				status_formatter = nil
			}
		end
	}

	use { -- Make the background of a string representing a color with the color it represents
		'norcalli/nvim-colorizer.lua',
		event = 'BufRead',
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
		event = 'InsertEnter',
		config = function() 
			vim.o.completeopt = "menuone,noselect"
			require('vendor.nvim-compe')
		end -- Use the file we vendor from upstream
	}

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
		after = 'nvim-compe',
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

	-- List of filetypes that we want to enable nvim-treesitter in
	local filetypes = {
		'bash',
		'fish',
		'yaml',
		'toml',
		'python',
		'go',
		'gomod',
		'c',
		'cpp',
		'cmake',
		'lua',
		'json',
		'dockerfile',
		'regex',
		'comment',
		'query'
	}

	use { -- Unified highlight for all filetypes
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		ft = filetypes,
		config = function()
			require('nvim-treesitter.configs').setup{
				ensure_installed = filetypes,
				highlight = {
					enable = true
				},
				indent = {
					enable = true
				}
			}
		end
    }

	use {
		'kabouzeid/nvim-lspinstall',
		event = 'BufRead'
	}

	use { -- LSP configurations for builtin LSP client
		'neovim/nvim-lspconfig',
		after = 'nvim-lspinstall',
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

	use { -- automatically create missing directories when saving files, like `mkdir -p` 
		'jghauser/mkdir.nvim',
		event = 'BufWrite',
		config = function() require('mkdir') end
	}

	use { -- Automatically change working directory to the root of the repo
		'airblade/vim-rooter',
		config = function() 
			vim.g.rooter_patterns = {'.venv', '.git/', '.nvim/'}
		end
	}

	use { -- file manager
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		cmd = 'NvimTreeToggle',
		setup = function()
			vim.api.nvim_set_keymap('n', '<C-f>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
		end,
		config = function()
			vim.g.nvim_tree_ignore = {'.git', '.cache'}
			vim.g.nvim_tree_gitignore = true
			vim.g.nvim_tree_quit_on_open = false
			vim.g.nvim_tree_disable_netrw = true
			vim.g.nvim_tree_hijack_netrw = true
		end
	}

	use { -- tabline
		'romgrk/barbar.nvim',
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = function()
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			map('n', '<C-j>', ':BufferPrevious<CR>', opts)
			map('n', '<C-l>', ':BufferNext<CR>', opts)
			map('n', '<C-d>', ':BufferClose<CR>', opts)
		end
	}

	use { -- Show indentation levels
		'lukas-reineke/indent-blankline.nvim',
		event = 'BufRead',
		setup = function()
			vim.g.indentLine_enabled = true
			vim.g.indent_blankline_char = "▏"
			
			vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
			vim.g.indent_blankline_buftype_exclude = {"terminal"}
			
			vim.g.indent_blankline_show_trailing_blankline_indent = false
			vim.g.indent_blankline_show_first_indent_level = false
		end
	}

	use { -- Load autosave only if it is globally enabled
		'Pocco81/AutoSave.nvim',
		cond = function()
			return vim.g.auto_save == true
		end
	}

	use { -- Best shell
		'dag/vim-fish',
	}
end)
