let g:base_url = "http://"

command! -complete=file -nargs=? Get call GetJson(<q-args>)
nmap <leader>rg :call GetJson("")<CR>
vmap <leader>rg :call GetJson(GetVisualSelection())<CR>
function! GetJson(url)
  let url = a:url
  if url==""
    let url = input("Url: ", g:base_url)
  endif
  call RunShellCommand("curl -D - " . url)
  1
endfunction

vmap <leader>rp :call PostJson()<CR>
function! PostJson() range
  let host = input("Url: ", g:base_url)

  let content = GetVisualSelection()
  let contentFile = tempname()
  call writefile(split(content, "\n"), contentFile)

  let cmd = "curl -X POST -H \"Content-Type: application/json\" -D - --data \@" . contentFile . " " . host
  call RunShellCommand(cmd)
  return 1
endfunction

function! GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! Sum() range
  let content = GetVisualSelection()
  let sum = 0
  for i in split(content, "\n")
    let sum = sum + i
  endfor
  echo sum
endfunction
