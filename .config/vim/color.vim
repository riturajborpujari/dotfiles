if has('termguicolors')
    " Turns on true terminal colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Turns on 24-bit RGB color support
    set termguicolors

    " Defines how many colors should be used. (maximum: 256, minimum: 0)
    set t_Co=256
endif

set background=dark

colorscheme gruvbox
hi Pmenu guibg=NONE
hi LspErrorText ctermfg=203 ctermbg=none
hi LspErrorHighlight ctermfg=203 ctermbg=none cterm=underline
hi LspHintText ctermfg=144 ctermbg=none cterm=none
hi LineNr guifg=#e5c07b
hi LineNrAbove ctermfg=243
hi LineNrBelow ctermfg=243
hi Colorcolumn guibg=#1d2021

hi Statement ctermfg=203 guifg=#fe8019
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Keyword Statement
hi! link Label Statement
hi! link Exception Statement
hi! link Operator Statement

hi! link Function Identifier

