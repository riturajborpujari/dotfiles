syntax match cFunc "[A-Za-z_][A-Za-z0-9_]*\ze("
hi! link cFunc Function
syntax clear cErrInParen

runtime ftplugin/man.vim
let g:ft_man_open_mode = 'vert'

nmap <leader>k	:Man 
nmap <silent>K	:Man <cword><cr>
