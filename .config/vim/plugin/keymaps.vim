let g:mapleader = " "

nmap <C-d>                  <C-d>zz
nmap <C-u>                  <C-u>zz
nmap n                      nzzzv
nmap N                      Nzzzv
nmap {                      {zzzv
nmap }                      }zzzv

" copy to / paste from clipboard
nmap <silent> <leader>y     "+y
nmap <silent> <leader>Y     "+Y
nmap <silent> <leader>p     "+p
nmap <silent> <leader>P     "+P

vmap <silent> <leader>y     "+y
vmap <silent> <leader>Y     "+Y
vmap <silent> <leader>p     "+p
vmap <silent> <leader>P     "+P

nmap <leader>t              :vertical terminal<cr>

nmap gls                    :ls<cr>:b 
nmap gwo                    :Files<cr>
nmap gln                    :cn<cr>
nmap gns                    :SessionSave 
nmap gnl                    :SessionLoad 
nmap glp                    :cp<cr>
nmap ]l                     :lne<cr>
nmap [l                     :lp<cr>
nmap <silent> gwv           :20Lex<cr>

" group move lines
vmap <C-p>                  :m '<-2<cr>gv=gv
vmap <C-n>                  :m '>+1<cr>gv=gv

" lsp mappings
function s:enable_lsp_mappings() abort
    nmap K                      :LspHover<cr>
    nmap <buffer> <expr><c-n>   lsp#scroll(+4)
    nmap <buffer> <expr><c-p>   lsp#scroll(-4)
    nmap gd                     :LspDefinition<cr>
    nmap gh                     :LspReferences<cr>
    nmap gp                     :LspDocumentFormat<cr>
    nmap gs                     :LspDocumentSymbolSearch<cr>
    nmap gws                    :LspWorkspaceSymbolSearch<cr>
    nmap <silent>gkd            :call Custom_vim_lsp_show_diagnostic()<cr>
    nmap <silent>gkp            :LspPreviousDiagnostic<cr>gK
    nmap <silent>gkn            :LspNextDiagnostic<cr>gK
    nmap gka                    :LspDocumentDiagnostics<cr>
    nmap g.                     :LspCodeAction<cr>
    imap <C-i>                  <cmd>LspSignatureHelp<cr>
    imap <C-Space>              <Plug>(asyncomplete_force_refresh)
endfunction
autocmd User lsp_buffer_enabled call s:enable_lsp_mappings()

function! Custom_vim_lsp_show_diagnostic()
    let l:diagnostic = lsp#internal#diagnostics#under_cursor#get_diagnostic()
    if has_key(l:diagnostic, 'message')
        let l:winid = lsp#ui#vim#output#floatingpreview("")
        let l:message = l:diagnostic['message']
        call setbufvar(winbufnr(l:winid), 'lsp_do_conceal', 1)
        call lsp#ui#vim#output#setcontent(l:winid, l:message, 'markdown')
    endif
endfunction
