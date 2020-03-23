"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start pathogen
call plug#begin('~/etc/nvim/autoload')

" Better visuals for line indentation
Plug 'Yggdroot/indentLine'

" Shows + - ~ signs on the left-side corner based on git differences
Plug 'airblade/vim-gitgutter'

" Statusbar on the bottom that shows important information like:
" - vim mode
" - file path
" - file encoding
" - file type
Plug 'itchyny/lightline.vim'

" Async Lint engine, allows us to run linters
Plug 'dense-analysis/ale'

let g:ale_fix_on_save = 1
let g:ale_fixers = {
			\	'python': ['isort', 'black']
			\	}
let g:ale_linters = {
			\	'python': ['vulture', 'flake8']
			\	}

" Colorscheme
" Plug 'sonph/onehalf', { 'rtp': 'vim' }

Plug 'danilo-augusto/vim-afterglow'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

let g:deoplete#enable_at_startup = 1

Plug 'deoplete-plugins/deoplete-jedi', { 'for': 'python' }

" For Semshi
let g:deoplete#auto_complete_delay = 100 

Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': 'python' }

" Support for using the uncompromising formatter for python3
Plug 'psf/black', { 'tag': '19.10b0', 'for': 'python' }

" Add Plugins
"
call plug#end()

let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
    \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileencoding', 'filetype'] ]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'filetype': 'LightlineFiletype',
    \   'fileencoding': 'LightlineFileencoding',
    \   'mode': 'LightlineMode',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' }
    \ }

"
" funtions for lightline
"
function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%')
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')

endfunction

function! LightlineFiletype()
  return &filetype !=# '' ? &filetype : 'no ft'
endfunction

function! LightlineFileencoding()
  return &fenc !=# '' ? &fenc : &enc
endfunction

function! LightlineMode()
  return lightline#mode()
endfunction

" Signify
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

set clipboard=unnamed,unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" Sets how many lines of history VIM has to remember
set history=20

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ','
let g:mapleader = ','

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set cursorline

" Fast quitting
nmap <leader>q :wq<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
syntax on

" Languages with spell
set spelllang=en

set guicursor=

set t_Co=256
set background=dark

let g:afterglow_inherit_background = 1
let g:afterglow_italic_comments = 1

colorscheme afterglow

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
scriptencoding utf-8

" Use Unix as the standard file type
set ffs=unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
" set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 50 characters
set formatoptions+=t
set lbr
set tw=100

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
augroup reopen
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Show lines
set number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Use ripgrep as grep if possible
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
