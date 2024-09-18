if executable('pyright')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyright',
        \ 'cmd': {server_info->['pyright']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('tsserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'tsserver',
        \ 'cmd': {server_info-> ['typescript-language-server','--stdio']},
        \ 'allowlist': ['typescript', 'javascript', 'javascriptreact', 'typescriptreact'],
        \ })
endif

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls-server',
        \ 'cmd': {server_info->['gopls']},
        \ 'allowlist': ['go'],
        \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd-server',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c', 'h', 'cpp', 'hpp'],
        \ })
endif

let g:lsp_semantic_enabled=1
let g:lsp_signature_help_enabled=0
let g:asyncomplete_auto_popup=0
let g:asyncomplete_auto_completeopt=0

let g:lsp_diagnostics_highlights_delay=50	   
let g:lsp_diagnostics_virtual_text_delay=50   
let g:lsp_diagnostics_highlights_insert_mode_enabled=1
let g:lsp_diagnostics_virtual_text_insert_mode_enabled=1

let g:lsp_diagnostics_virtual_text_prefix='🬇 '   
let g:lsp_diagnostics_virtual_text_align="after"    
let g:lsp_diagnostics_virtual_text_padding_left=6
