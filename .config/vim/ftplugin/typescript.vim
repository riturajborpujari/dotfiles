set path=src/**

hi Function guifg=NONE
hi myFunc guifg=#f5c04b
call matchadd('myFunc', '\<[A-Za-z_][A-Za-z0-9_]*\>\ze(')
