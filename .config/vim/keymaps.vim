let g:mapleader = " "

nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap n nzzzv
nmap N Nzzzv

" copy to / paste from clipboard
nmap <silent> <leader>y "+y
nmap <silent> <leader>Y "+Y
nmap <silent> <leader>p "+p
nmap <silent> <leader>P "+P

vmap <silent> <leader>y "+y
vmap <silent> <leader>Y "+Y
vmap <silent> <leader>p "+p
vmap <silent> <leader>P "+P

" lsp mappings
function s:enable_lsp_mappings() abort
    nmap K :LspHover<cr>
    nmap gd :LspDefinition<cr>
    nmap gh :LspReferences<cr>
    nmap gy :LspTypeDefinition<cr>
    nmap gp :LspDocumentFormat<cr>
    nmap gs :LspDocumentSymbolSearch<cr>
    nmap gws :LspWorkspaceSymbolSearch<cr>
    nmap [d :LspPreviousDiagnostic<cr>
    nmap ]d :LspNextDiagnostic<cr>
    nmap g. :LspCodeAction<cr>
    imap <C-i> <cmd>call lsp#ui#vim#signature_help#get_signature_help_under_cursor()<cr>
    imap <C-Space> <Plug>(asyncomplete_force_refresh)
endfunction

autocmd User lsp_buffer_enabled call s:enable_lsp_mappings()

nmap gb :ls<cr>:b 
nmap ]q :cn<cr>
nmap [q :cp<cr>
nmap ]Q :clast<cr>
nmap [q :cfirst<cr>
nmap <silent> gwv :Ex<cr>

" group move lines
vmap <C-p> :m '<-2<cr>gv=gv
vmap <C-n> :m '>+1<cr>gv=gv
