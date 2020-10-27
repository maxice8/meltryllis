"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start pathogen
call plug#begin()

Plug 'kaicataldo/material.vim', { 'branch': 'main' }

Plug 'vmchale/ion-vim', { 'for': 'ion' }

" Shows + - ~ signs on the left-side corner based on git differences
Plug 'airblade/vim-gitgutter'

" Statusbar on the bottom that shows important information like:
" - vim mode
" - file path
" - file encoding
" - file type
Plug 'itchyny/lightline.vim'

Plug 'dense-analysis/ale'

"
" Add Plugins
"
call plug#end()

let g:lightline = {
    \ 'colorscheme': 'material_vim',
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
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 0
let g:gitgutter_override_sign_column_highlight = 0

let g:ale_completion_enabled = 1

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Clipboard
set clipboard+=unnamed,unnamedplus

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

" Fast save and quit
map <Enter> :update<cr>

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

" Configuration for theme
let g:material_terminal_italics = 1
let g:material_theme_style = 'darker'
colorscheme material

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
" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=2
set tabstop=4
set softtabstop=4

set ai "Auto indent
set si "Smart indent
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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Alpine LInux
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" It is a shellscript after all
autocmd BufRead APKBUILD
				\ set filetype=sh |
				\ set noexpandtab |
				\ set textwidth=79 |
				\ let g:ale_sh_shellcheck_executable = 'ale-shellcheck'
