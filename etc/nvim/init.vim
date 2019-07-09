"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start pathogen
call plug#begin('~/var/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'w0rp/ale'
Plug 'tpope/vim-git'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'igankevich/mesonic'
Plug 'KeitaNakamura/neodark.vim'
Plug 'vimwiki/vimwiki'

" Add Plugins
"
call plug#end()

let g:lightline = {
    \ 'colorscheme': 'neodark',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'filename' ] ],
    \   'right': [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype'] ]
    \ },
    \ 'component_function': {
    \   'filename': 'LightlineFilename',
    \   'fileformat': 'LightlineFileformat',
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

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Signify
let g:gitgutter_realtime = 1
let g:gitgutter_override_sign_column_highlight = 0

" Remove folding
let g:vim_markdown_folding_disabled = 1

" If there's a `meson.build` file, use meson for linting.
autocmd FileType c call ConsiderMesonForLinting()
function ConsiderMesonForLinting()
    if filereadable('meson.build')
        let g:syntastic_c_checkers = ['meson']
    endif
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
set errorformat=%f:%l:\ %m

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

au BufReadPre,BufNewFile *.sh let g:is_bash = 1

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

" Syntastic error highlighting colors
hi SpellBad ctermfg=015 ctermbg=160 guifg=#ffffff guibg=#d70000
hi SpellCap ctermfg=015 ctermbg=160 guifg=#ffffff guibg=#d70000
highlight link SyntasticError SpellBad
highlight link SyntasticWarning SpellCap

" Fast quitting
nmap <leader>q :wq<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable
syntax on

" Set spellchecker on Markdown files and git commits
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd BufRead,BufNewFile *.7 setlocal spell
autocmd FileType gitcommit setlocal spell

" Get free word completion
set complete+=kspell

if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)')
  autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|TEST\)')
endif

" Required to keep sane cursor
set guicursor=
set guifont=Hack

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set t_Co=256
set background=dark

colorscheme neodark

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
set tw=500

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

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

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

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr('%')
   let l:alternateBufNum = bufnr('#')

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr('%') == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute('bdelete! '.l:currentBufNum)
   endif
endfunction

"
" User funtions
"
set pastetoggle=<F2>

" Use ripgrep as grep if possible
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
