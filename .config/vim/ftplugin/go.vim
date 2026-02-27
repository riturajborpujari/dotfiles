set path+=**
syntax match goFunc "[A-Za-z_][A-Za-z0-9_]*\ze("
hi! link goFunc Function

nnoremap K         :GoDoc<cr>
nnoremap <leader>k :GoDoc 
