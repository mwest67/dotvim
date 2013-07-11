" DBExt settings
"let g:dbext_default_use_sep_result_buffer = 1
"let g:dbext_default_profile_devAccountManager = 'type=SQLSRV:integratedlogin=1:srvname=hlsdbdev01t\fr0d0:dbname=accountmanager_v1'
"let g:dbext_default_profile_devWebDbV4 = 'type=SQLSRV:integratedlogin=1:srvname=hlsdbdev01t\fr0d0:dbname=WebDBV4'
"let g:dbext_default_profile_devBackhouse = 'type=SQLSRV:integratedlogin=1:srvname=hlsdbdev01t\fr0d0:dbname=Backhouse'
"let g:dbext_default_profile = 'devBackhouse'
""noremap <leader>ht :DBExecSQL sp_helptext <C-R>=expand("<cword>") <CR><CR>

"function! SetUpDBDicts()
"  :DBCompleteTables
"  :DBCompleteViews
"  :DBCompleteProcedures
"endfunction
"command! SetupDBDictionaries silent! :call SetUpDBDicts()
