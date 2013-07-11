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
  autocmd FileType ruby,perl,python,dosbatch :call MapAutoCloseQuotesAndBrackets()
  autocmd FileType ruby,dot :call SetupDashRocket()
endif
