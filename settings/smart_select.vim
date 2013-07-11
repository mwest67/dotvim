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

