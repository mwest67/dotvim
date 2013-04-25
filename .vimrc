set encoding=utf8
call pathogen#runtime_append_all_bundles()
silent! call pathogen#helptags()

set nocompatible
filetype plugin on
runtime macros/matchit.vim

" Gui Stuff
colorscheme github
set guifont=Lucida_Console:h10:cANSI
set guioptions-=T

" Folding settings
setlocal foldmethod=syntax
setlocal nofoldenable
setlocal foldlevelstart=99

" Whitespace
set smarttab " smart tabulatin and backspace
set smartindent
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

" allows hidden buffers to stay unsaved, but we do not want this, so comment
" it out:
"set hidden

"set wmh=0

" auto-detect the filetype
filetype plugin indent on

" syntax highlight
syntax on

" Always show the menu, insert longest match
set completeopt=menuone,longest

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).

function! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function! QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<Left>"
  endif
endf

function! MapAutoCloseQuotesAndBrackets()
  inoremap " ""<Left>
  inoremap ' ''<Left>
  inoremap ( ()<Left>
  inoremap [ []<Left>
  inoremap { {}<Left>
  inoremap ) <c-r>=ClosePair(')')<CR>
  inoremap ] <c-r>=ClosePair(']')<CR>
  inoremap } <c-r>=ClosePair('}')<CR>
  inoremap " <c-r>=QuoteDelim('"')<CR>
  inoremap ' <c-r>=QuoteDelim("'")<CR>
  inoremap <C-CR> <Esc>A<CR>
  inoremap <C-e> <Esc>A<CR>
endfunction

function! SetupDashRocket()
  inoremap <C-a> <Space>-><Space>
endfunction 

if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  autocmd BufNewFile,BufRead *.vb set ft=vbnet
  autocmd FileType ruby,perl,python,dosbatch :call MapAutoCloseQuotesAndBrackets()
  autocmd FileType ruby,dot :call SetupDashRocket()
  autocmd FileType sql silent! :call SetUpDBDicts()
endif

" NERN Tree Options
let NERDChristmasTree = 1
let NERDTreeChDirMode = 2
let NERDTreeHighlightCursorline = 1
let NERDTreeHijackNetrw = 1

if $COLORTERM == 'gnome-terminal'
   set term=gnome-256color
endif

" Auto match string and block chars


"Set the key to toggle NERDTree
nnoremap <leader>d :NERDTreeToggle<cr>

" DBExt settings
let g:dbext_default_use_sep_result_buffer = 1
let g:dbext_default_profile_devAccountManager = 'type=SQLSRV:integratedlogin=1:srvname=hlsdbdev01t\fr0d0:dbname=accountmanager_v1'
let g:dbext_default_profile_devWebDbV4 = 'type=SQLSRV:integratedlogin=1:srvname=hlsdbdev01t\fr0d0:dbname=WebDBV4'
let g:dbext_default_profile_devBackhouse = 'type=SQLSRV:integratedlogin=1:srvname=hlsdbdev01t\fr0d0:dbname=Backhouse'
let g:dbext_default_profile = 'devBackhouse'

"Snippet Settings
let g:snips_author = 'Mike West'

" functions
command! -complete=file -nargs=+ Shell call RunShellCommand(<q-args>)
function! RunShellCommand(cmdline)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1,a:cmdline)
  call setline(2,substitute(a:cmdline,'.','=','g'))
  execute 'silent $read !'.escape(a:cmdline,'%#')
  setlocal nomodifiable
  1
endfunction
noremap <leader>ht :DBExecSQL sp_helptext <C-R>=expand("<cword>") <CR><CR>

command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction
 
function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction


" Bubble single lines blah
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Visually select the text that was last edited/pasted
nmap gV `[v`]


function! SetUpDBDicts()
  :DBCompleteTables
  :DBCompleteViews
  :DBCompleteProcedures
endfunction
command! SetupDBDictionaries silent! :call SetUpDBDicts()

nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a  :Tabularize /
vmap <Leader>a  :Tabularize /

inoremap <silent>  <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

nmap <Leader>mh :call <SID>makeHeader('header')<CR>
nmap <Leader>mf :call <SID>makeHeader('footer')<CR>

function! s:makeHeader(type)
  let p = '^\s*|\s.*\s|\s*$'

  let len = strlen(getline('.'))

  if a:type != 'footer'
    call append(line('.') -1, '')
  endif

  call append(line('.'), '')

  let line = ""
  for i in range(0, len - 1)
    if getline('.')[i] == '|' 
      let line .= '+'
    else
      let line .= '-'
    endif
  endfor

  if a:type != 'footer'
    call setline(line('.') -1, line)
  endif

  call setline(line('.') +1, line)

endfunction

" Gundo Plugin Mapping
nnoremap <F5> :GundoToggle<CR>
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:?\ ,eol:¬
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

if has("gui_running")
  set lines=50 columns=120
else
  " This is console Vim.
  if exists("+lines")
    set lines=50
  endif
  if exists("+columns")
    set columns=120
  endif
endif

" Error format that works with rake & ruby compiler output (default from
" commandline)
"
set errorformat=%f(%l)\ :\ %t%*\\D%n:\ %m,%*[^\"]\"%f\"%*\\D%l:\ %m,%f(%l)\ :\ %m,%*[^\ ]\ %f\ %l:\ %m,%f:%l:%c:%m,%f(%l):%m,%f:%l:%m,%f\|%l\|\ %m

set backupdir=c:\tmp\vimtemp
set directory=c:\tmp\vimtemp


function! s:SmartSelect(type)
    let ln = getline('.')
    let leftstop = ''
    let rightstop = ''
    let lpos = col('.') - 1
    let rpos = col('.') - 1
    while lpos > 0 || rpos < len(ln)
        if leftstop == ''
            for stp in ["\"", "'", "(", "[", "{"]
                if ln[lpos] == stp
                    let leftstop = stp
                endif
            endfor
        endif
        if rightstop == ''
            for stp in ["\"", "'", ")", "]", "}"]
                if ln[rpos] == stp
                    let rightstop = stp
                endif
            endfor
        endif
        let lpos = lpos - 1
        let rpos = rpos + 1
    endwhile

    let selstp = ''
    if rightstop != '' && rightstop == leftstop
        let selstp = rightstop
    elseif rightstop !='' && rightstop != "'" && rightstop != "\""
        let selstp = rightstop
    elseif leftstop !='' && leftstop != "'" && leftstop != "\""
        let selstp = leftstop
    elseif rightstop != ''
        let selstp = rightstop
    end
    if selstp != ''
        let cmd = "normal! v" . a:type . selstp
        exe cmd
    end
endfunction

nnoremap <silent> viv :call <SID>SmartSelect('i')<CR>
nnoremap <silent> vav :call <SID>SmartSelect('a')<CR>

set shell=C:\Windows\system32\cmd.exe\ /d

nmap <buffer> <M-r> <Plug>(xmpfilter-run)
xmap <buffer> <M-r> <Plug>(xmpfilter-run)
imap <buffer> <M-r> <Plug>(xmpfilter-run)

nmap <buffer> <M-m> <Plug>(xmpfilter-mark)
xmap <buffer> <M-m> <Plug>(xmpfilter-mark)
imap <buffer> <M-m> <Plug>(xmpfilter-mark)

map <F6> :set spell!<CR>
