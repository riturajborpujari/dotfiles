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

hi String guifg=#ff4f40
hi Constant guifg=#f64f40
hi Character guifg=#f64f40
hi Number guifg=#f64f40
hi Boolean guifg=#f64f40
hi Float guifg=#f64f40

hi Function guifg=#d0d080 ctermfg=NONE cterm=none

hi Statement guifg=#FFD449
hi Conditional guifg=#FFD449
hi Repeat guifg=#FFD449
hi Label guifg=#FFD449
hi Operator guifg=#FFD449
hi Keyword guifg=#FFD449
hi Exception guifg=#FFD449

hi Identifier guifg=#d0d0d0 ctermfg=NONE cterm=none
hi Type guifg=#d0d0d0
hi StorageClass guifg=#d0d0d0
hi Structure guifg=#d0d0d0
hi Typedef guifg=#d0d0d0

hi PreProc guifg=#ffd449
hi Include guifg=#ffd449
hi Define guifg=#ffd449
hi Macro guifg=#ffd449
hi PreCondit guifg=#ffd449

hi Special guifg=#ffd449

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
