let g:mapleader = " "

nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap n nzzzv
nmap N Nzzzv
nmap { {zzzv
nmap } }zzzv

" copy to / paste from clipboard
nmap <silent> <leader>y "+y
nmap <silent> <leader>Y "+Y
nmap <silent> <leader>p "+p
nmap <silent> <leader>P "+P

vmap <silent> <leader>y "+y
vmap <silent> <leader>Y "+Y
vmap <silent> <leader>p "+p
vmap <silent> <leader>P "+P

nmap gls     :ls<cr>:b 
nmap <A-1> :b1<cr>
nmap <A-2> :b2<cr>
nmap <A-3> :b3<cr>
nmap ]q  :cn<cr>
nmap [q  :cp<cr>
nmap ]Q  :clast<cr>
nmap [Q  :cfirst<cr>
nmap ]l  :lne<cr>
nmap [l  :lp<cr>
nmap <silent> gwv :20Lex<cr>

" group move lines
vmap <C-p> :m '<-2<cr>gv=gv
vmap <C-n> :m '>+1<cr>gv=gv

" lsp mappings
function s:enable_lsp_mappings() abort
    nmap K :LspHover<cr>
    nmap gd :LspDefinition<cr>
    nmap gh :LspReferences<cr>
    nmap gp :LspDocumentFormat<cr>
    nmap gs :LspDocumentSymbolSearch<cr>
    nmap gws :LspWorkspaceSymbolSearch<cr>
    nmap [d :LspPreviousDiagnostic<cr>
    nmap ]d :LspNextDiagnostic<cr>
    nmap ]a :LspDocumentDiagnostics<cr>
    nmap g. :LspCodeAction<cr>
    imap <C-i> <cmd>LspSignatureHelp<cr>
    imap <C-Space> <Plug>(asyncomplete_force_refresh)
endfunction

autocmd User lsp_buffer_enabled call s:enable_lsp_mappings()
