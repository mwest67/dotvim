" Visually select the text that was last edited/pasted
nmap gV `[v`]

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:?\ ,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! s:DiffBacked()
  let filetype=&ft

  let stream = split(system("accurev info | findstr Basis"))[1]
  let file = expand("%:p")
  let cmd = 'accurev cat -v ' . stream . ' ' . file 
  let content = system(cmd)
  diffthis
  vnew | call append(line('$'), split(content, "\n")) | normal! 1Gddx
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffBacked call s:DiffBacked()

map <F6> :set spell!<CR>
