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

hi SpecialKey guifg=#282828
hi Pmenu guibg=#444444 guifg=NONE cterm=NONE
hi! link Visual Pmenu
hi PmenuThumb guibg=#f5c04b
hi PmenuSel guibg=#f5c04b guifg=#181818 cterm=NONE
hi PmenuSbar guibg=NONE ctermbg=NONE
hi Normal guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
hi LineNr guifg=#f5c04b
hi LineNrAbove guifg=#444444 ctermfg=240
hi LineNrBelow guifg=#444444 ctermfg=240

hi String guifg=#30d020
hi! link Constant String
hi! link Character String
hi! link Number String
hi! link Boolean String
hi! link Float String

hi Statement guifg=#efefef cterm=NONE
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Operator Statement
hi! link Keyword Statement
hi! link Exception Statement
hi! link Include Statement
hi! link Define Statement
hi! link Macro Statement
hi! link PreCondit Statement
hi! link Special Function

hi Identifier guifg=NONE ctermfg=NONE cterm=none
hi Function guifg=#fdc04b ctermfg=NONE cterm=NONE gui=NONE
hi Type guifg=#d0e0d0 gui=NONE cterm=NONE
hi! link StorageClass Type
hi! link Structure Type
hi! link Typedef Type

hi PreProc guifg=#f5c04b

hi Comment guifg=#e08030
hi ColorColumn guibg=#181818
hi CursorLine cterm=NONE guibg=#0a0a0a guifg=NONE
hi CursorLineNr cterm=NONE guifg=#f5c04b
hi StatusLine guifg=#f5c04b guibg=#242424 cterm=NONE gui=NONE
hi StatusLineNC guifg=#666666 guibg=#1d1d1d cterm=NONE
hi! link StatusLineTermNC StatusLineNC
hi! link StatusLineTerm StatusLine
hi VertSplit guifg=#181818 guibg=#999999
hi Folded guibg=#303030 guifg=#999999
hi CursorColumn guibg=NONE guifg=#e4e4e0  cterm=NONE

hi! link Todo Statement
hi MatchParen guibg=#606060 guifg=#e5c07b
hi NonText guifg=#444444

hi netrwDir guifg=#bbbbbb guibg=NONE cterm=NONE

hi LspErrorText ctermfg=203 ctermbg=none
hi LspErrorHighlight guifg=NONE ctermfg=NONE cterm=underline
hi LspHintText ctermfg=144 ctermbg=none cterm=none
