let g:syntastic_ruby_checkers=['mri']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
set shellpipe=>%s\ 2>&1
