"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start pathogen
call plug#begin()

Plug 'ajmwagar/vim-deus'

" For Ion shell
Plug 'vmchale/ion-vim', { 'for': 'ion' }

Plug 'junegunn/vader.vim'

Plug 'editorconfig/editorconfig-vim'

" Support for scdoc, used to write manapges
Plug 'gpanders/vim-scdoc'

" It is not on GitHub so we need full path, also there is no 'for'
" because it is the ftype required
Plug 'https://gitlab.alpinelinux.org/Leo/apkbuild.vim.git'

" Shows + - ~ signs on the left-side corner based on git differences
Plug 'airblade/vim-gitgutter'

" Statusbar on the bottom that shows important information like:
" - vim mode
" - file path
" - file encoding
" - file type
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

Plug 'dense-analysis/ale'

"
" Add Plugins
"
call plug#end()

let g:lightline = {'active':{'left':[], 'right':[]}}

let g:lightline.active.left = [ [ 'mode', 'paste' ], [ 'filename' ] ]

let g:lightline.active.right = [ 
    \   [ 'lineinfo' ],
    \   ['percent'],
    \   [ 'fileencoding', 'filetype' ],
    \   [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok' ]
    \]

let g:lightline.component_function = {
    \   'component_function': {
    \       'filename': 'LightlineFilename',
    \       'filetype': 'LightlineFiletype',
    \       'fileencoding': 'LightlineFileencoding',
    \       'mode': 'LightlineMode',
    \   }
    \}

let g:lightline.colorscheme = 'deus'

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '|', 'right': '|' }

" Components for lightline in lightline
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_infos': 'lightline#ale#infos',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'right',
      \     'linter_infos': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'right',
      \ }

" funtions for lightline
"
function! LightlineModified()
  return &filetype =~# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &filetype !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%')
  return ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=# fname ? fname : '[No Name]') .
        \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')

endfunction

function! LightlineFiletype()
  return &filetype !=# '' ? &filetype : 'no ft'
endfunction

function! LightlineFileencoding()
  return &fileencoding !=# '' ? &fileencoding : &encoding
endfunction

function! LightlineMode()
  return lightline#mode()
endfunction

" Signify
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

let g:ale_completion_enabled = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'apkbuild': ['shellcheck', 'apkbuild_lint', 'secfixes_check'],
\}

" Clipboard
set clipboard+=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=20

" Enable filetype plugins
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ','
let g:mapleader = ','

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Fast save
nmap <leader>s :update<cr>

" Fast quitting
nmap <leader>q :update<cr>:quit<cr>

" Fast save
map <Enter> :w<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
syntax on

" Use the cursor from the terminal
set guicursor=

" Colorscheme
if (has('termguicolors'))
  set termguicolors
endif

set t_Co=256

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set background=dark    " Setting dark mode
colorscheme deus
let g:deus_termcolors=256

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
scriptencoding utf-8

" Use Unix as the standard file type
set fileformats=unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Be smart when using tabs ;)
set smarttab


" The width of a TAB is set to 4.
" Still it is a \t. It is just that
" Vim will interpret it to be having
" a width of 4.
set tabstop=4

" Indents will have a width of 4
set shiftwidth=4

" Sets the number of columns for a TAB
set softtabstop=4

" Expand TABs to spaces
set expandtab

set autoindent "Auto indent
set smartindent "Smart indent
set wrap "Wrap lines

" Return to last edit position when opening files (You want this!)
augroup reopen
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
" used by lightline
set laststatus=2

" Remove the insert and other modifiers as they are shown in lightline
set noshowmode

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

" Quickly tracking syntax highlighting for debugging
function! s:syntax_query() abort
  for id in synstack(line('.'), col('.'))
    echo synIDattr(id, 'name')
  endfor
endfunction
command! SyntaxQuery call s:syntax_query()


map <leader>sq :SyntaxQuery<cr>
map <leader>n :next<cr>
map <leader>p :prev<cr>

let g:is_posix = 1
