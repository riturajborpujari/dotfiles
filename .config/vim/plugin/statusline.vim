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
set statusline+=\ %f\ %=%3*%m%*\ %2*%y%*\ %l,%c\ 
set statusline+=%{mode()}
set noshowmode

hi User1 guibg=#2288dd guifg=#282828
hi User2 guibg=#363636 guifg=#2288dd
hi User3 guibg=#363636 guifg=#dd8822
hi User4 guibg=#22dd88 guifg=#282828
hi User5 guibg=#dd8822 guifg=#282828
hi User6 guibg=#dd2288 guifg=#282828
hi User7 guibg=#dd2222 guifg=#282828
