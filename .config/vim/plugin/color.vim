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

hi Pmenu guibg=#2f2f2f
hi PmenuThumb guibg=#666666
hi PmenuSel guibg=#666666 guifg=NONE ctermfg=NONE
hi PmenuSbar guibg=NONE ctermbg=NONE
hi Normal guibg=NONE guifg=#a0a0a0
hi LineNr guifg=#e5c07b
hi LineNrAbove ctermfg=240
hi LineNrBelow ctermfg=240

hi String guifg=#22aa33
hi! link Constant String
hi! link Character String
hi! link Number String
hi! link Boolean String
hi! link Float String

hi Statement guifg=#d0d0d0
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Operator Statement
hi! link Keyword Statement
hi! link Exception Statement

hi Identifier guifg=NONE ctermfg=NONE cterm=none
hi Function guifg=#e5c07b ctermfg=NONE cterm=none

hi Type guifg=#e0e0e0
hi! link StorageClass Type
hi! link Structure Type
hi! link Typedef Type

hi PreProc guifg=#e5c07b
hi! link Include Statement
hi! link Define Statement
hi! link Macro Statement
hi! link PreCondit Statement

hi Special guifg=#e5c07b
hi Comment guifg=#777777
hi ColorColumn guibg=#262626
hi CursorLine cterm=NONE guifg=#e5c07b guibg=NONE
hi CursorLineNr cterm=NONE guifg=#e5c07b
hi StatusLine guifg=#bbbbbb guibg=#333333 cterm=NONE
hi StatusLineNC guifg=#666666 guibg=#333333 cterm=NONE
hi VertSplit guifg=#303030 guibg=#999999
hi Folded guibg=#303030 guifg=#999999
hi CursorColumn guibg=NONE guifg=#e4e4e0  cterm=NONE

hi! link Todo Statement
hi MatchParen guibg=#606060 guifg=#e5c07b
hi NonText guifg=#444444

hi netrwDir guifg=#bbbbbb guibg=NONE cterm=NONE

hi LspErrorText ctermfg=203 ctermbg=none
hi LspErrorHighlight guifg=NONE ctermfg=NONE cterm=underline
hi LspHintText ctermfg=144 ctermbg=none cterm=none
