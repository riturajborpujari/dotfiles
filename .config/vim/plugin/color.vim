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

" colorscheme gruvbox
hi Pmenu guibg=#2f2f2f
hi PmenuThumb guibg=#666666
hi PmenuSel guibg=#666666 guifg=NONE ctermfg=NONE
hi PmenuSbar guibg=NONE ctermbg=NONE
hi Normal guibg=NONE
hi LspErrorText ctermfg=203 ctermbg=none
hi LspErrorHighlight ctermfg=203 ctermbg=none cterm=underline
hi LspHintText ctermfg=144 ctermbg=none cterm=none
hi LineNr guifg=#e5c07b
hi LineNrAbove ctermfg=240
hi LineNrBelow ctermfg=240

hi String guifg=#e02c38
hi! link Constant String
hi! link Character String
hi! link Number String
hi! link Boolean String
hi! link Float String

hi Function guifg=#d0e080 ctermfg=NONE cterm=none

hi Statement guifg=#44aaee
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Operator Statement
hi! link Keyword Statement
hi! link Exception Statement

hi Identifier guifg=#d0d0d0 ctermfg=NONE cterm=none
hi Type guifg=#d0d0d0
hi StorageClass guifg=#d0d0d0
hi Structure guifg=#d0d0d0
hi Typedef guifg=#d0d0d0

hi PreProc guifg=#44aaee
hi! link Include Statement
hi! link Define Statement
hi! link Macro Statement
hi! link PreCondit Statement

hi Special guifg=#44aaee

hi Comment guifg=#777777
hi ColorColumn guibg=#262626

hi StatusLine guifg=#bbbbbb guibg=#333333 cterm=NONE
hi StatusLineNC guifg=#666666 guibg=#333333 cterm=NONE
hi netrwDir guifg=#bbbbbb guibg=NONE cterm=NONE
hi CursorLine cterm=NONE
hi VertSplit guifg=#303030 guibg=#999999
hi Folded guibg=#303030 guifg=#999999
hi CursorColumn guibg=NONE guifg=#e4e4e0 

hi! link Todo Statement
hi! link MatchParen Type
hi NonText guifg=#444444

hi LspErrorHighlight guifg=NONE ctermfg=NONE cterm=underline
