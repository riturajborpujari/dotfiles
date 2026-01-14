"if executable('typescript-language-server')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'tsserver',
"        \ 'cmd': {server_info-> ['typescript-language-server','--stdio']},
"        \ 'allowlist': ['typescript', 'javascript', 'javascriptreact', 'typescriptreact'],
"        \ })
"endif
"
"if executable('gopls')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'gopls-server',
"        \ 'cmd': {server_info->['gopls']},
"        \ 'allowlist': ['go'],
"        \ })
"endif
"
"if executable('pyright')
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyright-langserver',
"        \ 'cmd': {server_info->['pyright-langserver', '--stdio']},
"        \ 'allowlist': ['python'],
"        \ })
"endif

let g:lsp_use_native_client=0
let g:lsp_preview_auto_close=0
let g:lsp_preview_keep_focus=1
let g:lsp_hover_ui='float'
let g:lsp_semantic_enabled=0
let g:lsp_signature_help_enabled=0
let g:asyncomplete_auto_popup=0
let g:asyncomplete_auto_completeopt=0

let g:lsp_diagnostics_enabled=1
let g:lsp_diagnostics_float_cursor=0
let g:lsp_diagnostics_float_delay=100
let g:lsp_diagnostics_highlights_enabled=0
let g:lsp_diagnostics_virtual_text_enabled=0
let g:lsp_diagnostics_highlights_delay=50
" let g:lsp_diagnostics_virtual_text_delay=50   
" let g:lsp_diagnostics_highlights_insert_mode_enabled=1
" let g:lsp_diagnostics_virtual_text_insert_mode_enabled=1

" let g:lsp_diagnostics_virtual_text_prefix='🬇 '   
" let g:lsp_diagnostics_virtual_text_align="after"    
" let g:lsp_diagnostics_virtual_text_padding_left=6
