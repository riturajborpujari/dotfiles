set encoding=utf-8
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set backspace=indent,eol,start
set nu
set rnu
set signcolumn=yes
set foldenable
set foldmethod=indent
set foldlevel=0
set updatetime=300
set nocompatible
set completeopt=menu,menuone,preview,noselect,noinsert
set laststatus=2
set statusline=\ %f\ %=%m\ %y\ %l:%c\ 
filetype plugin indent on
syntax on
colorscheme slate-mod

" ALE config
let g:ale_fixers = {
\	'*':					['remove_trailing_lines', 'trim_whitespace'],
\ 'typescript': ['prettier'],
\ 'javascript': ['prettier'],
\ 'json':				['prettier'],
\ 'html':				['prettier'],
\ 'python':     ['black'],
\ 'markdown':   ['pandoc'],
\ 'cpp':        ['clang-format'],
\ 'rust':       ['rustfmt']
\}
let g:ale_linters = {
\ 'python': ['jedils'],
\ 'javascript': ['tsserver'],
\ 'typescript': ['tsserver'],
\ 'rust': ['analyzer']
\}

let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lsp_suggestions=1
let g:ale_floating_preview=1
let g:ale_floating_window_border=['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_hover_to_floating_preview=1
let g:ale_documentation_to_floating_preview=1
let g:ale_virtualtext_cursor = 0

"Vim Markdown
let g:vim_markdown_follow_anchor = 1

set omnifunc=ale#completion#OmniFunc

" Plugins
call plug#begin()
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
 	Plug 'dense-analysis/ale'
	Plug 'prettier/vim-prettier', { 'do': 'npm install' } 
  Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'preservim/vim-markdown', { 'for': 'markdown' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
call plug#end()

" normal mode keymappings
nnoremap <leader>d :NERDTreeToggle<cr>
nnoremap <leader>f :FZF<cr>
nnoremap <leader>j :b#<cr>
nnoremap <leader>p :bp<cr>
nnoremap <leader>n :bn<cr>
nnoremap <leader>l :ls<cr>
nnoremap <leader>w :vnew<cr>
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>q :pclose<cr>

nnoremap gp :ALEFix<cr>
nnoremap gl :ALELint<cr>
nnoremap gr :ALEFindReferences<cr>
nnoremap gd :ALEGoToDefinition<cr>
nnoremap gD :ALEGoToDefinition -vsplit<cr>
nnoremap g<c-d> :ALEGoToDefinition -split<cr>
nnoremap rn :ALERename<cr>
nnoremap gk :ALEDocumentation<cr>
nnoremap gK :ALEHover<cr>
