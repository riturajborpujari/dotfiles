function Modetext()
    if mode() == "i"
        return "Insert"
    elseif mode() == "n"
        return "Normal"
    elseif mode() ==# "v"
        return "Visual"
    elseif mode() ==# 'V'
        return "Visual Line"
    elseif mode() == "\<C-v>"
        return "Visual Block"
    elseif mode() == "c"
        return "Command"
    elseif mode() == "R"
        return "Replace"
    else
        return ""
endfunction

set statusline=
set statusline+=%1*%{(Modetext()==#'Normal')?'\ \ Normal\ ':''}%*
set statusline+=%4*%{(Modetext()=='Insert')?'\ \ Insert\ ':''}%*
set statusline+=%5*%{(Modetext()==#'Visual')?'\ \ Visual\ ':''}%*
set statusline+=%5*%{(Modetext()==#'Visual\ Line')?'\ \ Visual\ Line\ ':''}%*
set statusline+=%5*%{(Modetext()=='Visual\ Block')?'\ \ Visual\ Block\ ':''}%*
set statusline+=%6*%{(Modetext()=='Command')?'\ \ Command\ ':''}%*
set statusline+=%7*%{(Modetext()==#'Replace')?'\ \ Replace\ ':''}%*
set statusline+=\ %t\ %=%3*%m%*\ %2*%y%*\ %l,%c\ 
set noshowmode

autocmd ModeChanged * redrawstatus!

hi! link User1 Pmenu
hi! link User2 Type
hi! link User3 Comment
hi! link User4 String 
hi! link User5 Statement
hi! link User6 Type
hi! link User7 Comment
