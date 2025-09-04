nnoremap <silent> <C-s> :call SearchChar()<CR>

function! SearchChar()
    let c = nr2char(getchar())
    if c != "\<Esc>"
        echom c
        call feedkeys('/' . escape(c, '/\') . "\<CR>", 'n')
    endif
endfunction
