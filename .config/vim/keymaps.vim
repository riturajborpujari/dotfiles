let g:mapleader = " "

nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz
nmap n nzzzv
nmap N Nzzzv

" wayland copy to clipboard
nmap <silent> <leader>y "+y
vmap <silent> <leader>y "+y
nmap <silent> <leader>Y "+Y
vmap <silent> <leader>Y "+Y
nmap <silent> <leader>p "+p
vmap <silent> <leader>p "+p
nmap <silent> <leader>P "+P
vmap <silent> <leader>P "+P

" lsp mappings
nmap gk :LspHover<cr>
nmap gd :LspDefinition<cr>
nmap gh :LspReferences<cr>
nmap gy :LspTypeDefinition<cr>
nmap gp :LspDocumentFormat<cr>
nmap gwf :LspWorkspaceSymbolSearch<cr>
nmap g[d :LspPreviousDiagnostic<cr>
nmap g]d :LspNextDiagnostic<cr>
nmap g. :LspCodeAction<cr>

nmap gb :ls<cr>:b 
nmap <silent> <leader>pv :Ex<cr>

nmap <C-i> :LspSignatureHelp<cr>

" fuzzy mappings for scope
nmap <silent> <leader>fa :vim9cmd scope#fuzzy#File('fd -tf')<cr>
nmap <silent> <leader>ff :vim9cmd scope#fuzzy#GitFile()<cr>
nmap <silent> <leader>fg :vim9cmd scope#fuzzy#Grep()<cr>
nmap <silent> <leader>fb :vim9cmd scope#fuzzy#Buffer()<cr>

vmap <S-Tab> :m '<-2<cr>gv=gv
vmap <Tab> :m '>+1<cr>gv=gv

imap <C-Space> <Plug>(asyncomplete_force_refresh)
imap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
imap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
