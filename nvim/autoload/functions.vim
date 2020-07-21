" move to the window in the direction shown, or create a new window
function! functions#WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Jump to Tagbar and back
function! functions#TagbarToggleFocus()

    if (winnr() == bufwinnr('__Tagbar__'))
        for window in range(1, winnr('$'))
            execute window . 'wincmd w'
            if (exists('w:ReturnHere'))
                unlet w:ReturnHere
                break
            endif
        endfor
        TagbarClose
    else
        let g:cur_window = winnr()
        for window in range(1, winnr('$'))
            execute window . 'wincmd w'
            if (exists('w:ReturnHere'))
                unlet w:ReturnHere
            endif
        endfor
        execute g:cur_window . 'wincmd w'
        unlet g:cur_window
        let w:ReturnHere = 1
        TagbarOpen
        execute bufwinnr('__Tagbar__') . 'wincmd w'
    endif

    wincmd =

endfunction

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
