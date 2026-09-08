syntax match mdInlineCode /`[^`]\{-}`/ containedin=ALL
highlight link mdInlineCode Function

syntax match mdEmphasised /\*.*\*/ containedin=ALL
highlight mdEmphasised guifg=#f5c04b cterm=italic

syntax match mdBold /\*\*[A-za-z0-9-]*\*\*/ containedin=ALL
highlight mdBold guifg=#f5c04b cterm=bold
