let g:mapleader = " "

" Emacs style keybinds for the Command Mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
cnoremap <M-b> <C-Left>
cnoremap <M-f> <C-Right>
cnoremap <M-BS>	<C-w>
cnoremap <M-d> <C-del>

" ... and Insert Mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Del>
inoremap <M-b> <C-Left>
inoremap <M-f> <C-Right>
inoremap <M-BS>	<C-w>
inoremap <M-d> <C-del>

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

tmap <C-[>                          <C-W>N
tmap <C-W>p                         <C-W>""

nmap gl                             gF
nmap <silent><leader>t              :terminal<cr>
nmap <silent><leader>c              :terminal<cr><C-W>N:only<cr>i
nmap <leader>k						:Man 
nmap K								:Man <cword><cr>
nmap <leader>l                      :ls<cr>:b 
nmap <silent><leader>e              :Explore<cr>
nmap <silent><leader>we             :Explore .<cr>
nmap <leader>ns                     :SessionSave 
nmap <leader>nl                     :SessionLoad 
nmap <silent>]q                     :cn<cr>
nmap <silent>[q                     :cp<cr>
nmap <silent>]l                     :lne<cr>
nmap <silent>[l                     :lp<cr>

" group move lines
vmap <C-p>                  :m '<-2<cr>gv=gv
vmap <C-n>                  :m '>+1<cr>gv=gv
vnoremap >                          >gv
vnoremap <                          <gv

" lsp mappings
function s:enable_lsp_mappings() abort
    nmap K                          :LspHover<cr>
    nmap <buffer> <expr><c-a-n>     lsp#scroll(+4)
    nmap <buffer> <expr><c-a-p>     lsp#scroll(-4)
    nmap gd                         :LspDefinition<cr>
    nmap gh                         :LspReferences<cr>
    nmap gp                         :LspDocumentFormat<cr>
    nmap gs                         :LspDocumentSymbolSearch<cr>
    nmap gws                        :LspWorkspaceSymbolSearch<cr>
    nmap <silent><leader>d          :call Custom_vim_lsp_show_diagnostic()<cr>
    nmap <silent>]d                 :LspPreviousDiagnostic<cr>gK
    nmap <silent>[d                 :LspNextDiagnostic<cr>gK
    nmap gka                        :LspDocumentDiagnostics<cr>
    nmap g.                         :LspCodeAction<cr>
    imap <C-i>                      <cmd>LspSignatureHelp<cr>
    imap <C-Space>                  <Plug>(asyncomplete_force_refresh)
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
