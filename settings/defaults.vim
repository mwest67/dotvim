set nocompatible
filetype plugin on
runtime macros/matchit.vim

" Gui Stuff
colorscheme railscasts

set guifont=Consolas:h10:cANSI
set guioptions-=T

" Folding settings
setlocal foldmethod=syntax
setlocal nofoldenable
setlocal foldlevelstart=99

" Whitespace
set smarttab " smart tabulatin and backspaceset smartindent
set ts=2 sw=2 st=2
set expandtab
set autoindent

set fo=tcrq
set title " show title
set wildmenu
set wildchar=<Tab> " Expand the command line using tab
set nowrap
set clipboard+=unnamed

" show line numbers
set number

" enable all features
set nocompatible

set laststatus=2

" powerful backspaces
set backspace=indent,eol,start

" highlight the searchterms
set hlsearch

" jump to the matches while typing
set incsearch

" ignore case while searching
set ignorecase

" don't wrap words
set textwidth=80

" history
set history=50

" 1000 undo levels
set undolevels=1000

" show a ruler
set ruler

" show partial commands
set showcmd

" show matching braces
set showmatch
set mat=5

" write before hiding a buffer
set autowrite

" auto-detect the filetype
filetype plugin indent on

" syntax highlight
syntax on

" Always show the menu, insert longest match
set completeopt=menuone,longest

if $COLORTERM == 'gnome-terminal'
   set term=gnome-256color
endif

if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  autocmd BufNewFile,BufRead *.vb set ft=vbnet
endif


if has("gui_running")
  set lines=50 columns=180
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=180
  endif
endif

" Error format that works with rake & ruby compiler output (default from
" commandline)
"
""set errorformat=%f(%l)\ :\ %t%*\\D%n:\ %m,%*[^\"]\"%f\"%*\\D%l:\ %m,%f(%l)\ :\ %m,%*[^\ ]\ %f\ %l:\ %m,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,%f\|%l\|\ %m

set backupdir=c:\tmp\vimtemp
set directory=c:\tmp\vimtemp
set shell=C:\Windows\system32\cmd.exe\ /d

set diffopt+=iwhite
set diffexpr=""
