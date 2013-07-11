function! SetProcCheck()
  set errorformat=%f(%l\\,%c):%m
  set makeprg=pc\ \"%:p\"
endfunction


if has("autocmd")
  autocmd BufNewFile,BufRead *.prc set ft=sql
  autocmd FileType sql silent! :call SetProcCheck()
endif
