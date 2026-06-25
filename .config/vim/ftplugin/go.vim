set path+=**
syntax match goFunc "[A-Za-z_][A-Za-z0-9_]*\ze("
hi! link goFunc Function

nnoremap <buffer>K         :GoDoc<cr>
nnoremap <buffer><leader>k :GoDoc 
