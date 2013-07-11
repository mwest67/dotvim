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

