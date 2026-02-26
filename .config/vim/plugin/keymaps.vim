let g:mapleader = " "

" core keybinds
nmap <silent><leader>t				:terminal<cr>
nmap <leader>k						:Man 
nmap K								:Man <cword><cr>
nmap <leader>l						:ls<cr>:b 
nmap <silent><leader>e				:Explore<cr>
nmap <silent><leader>we				:Explore .<cr>
nmap <leader>ns						:SessionSave 
nmap <leader>nl						:SessionLoad 
nmap <silent>]q						:cn<cr>
nmap <silent>[q						:cp<cr>
nmap <silent>]l						:lne<cr>
nmap <silent>[l						:lp<cr>

" Emacs style keybinds for the Command Mode
cnoremap <C-a>						<Home>
cnoremap <C-e>						<End>
cnoremap <C-b>						<Left>
cnoremap <C-f>						<Right>
cnoremap <C-d>						<Del>
cnoremap <M-b>						<C-Left>
cnoremap <C-M-b>					<C-Left>
cnoremap <M-f>						<C-Right>
cnoremap <C-M-f>					<C-Right>
cnoremap <M-BS>						<C-w>
cnoremap <M-d>						<C-del>

" ... and Insert Mode
inoremap <C-a>						<Home>
inoremap <C-e> 						<End>
inoremap <C-b> 						<Left>
inoremap <C-f> 						<Right>
inoremap <M-b> 						<C-Left>
inoremap <M-f> 						<C-Right>
inoremap <M-BS>						<C-w>

" keep eye target at window center
nmap <C-d>							<C-d>zz
nmap <C-u>							<C-u>zz
nmap n								nzzzv
nmap N								Nzzzv
nmap {								{zzzv
nmap }								}zzzv

" copy to / paste from clipboard
nmap <silent> <leader>y				"+y
nmap <silent> <leader>Y				"+Y
nmap <silent> <leader>p				"+p
nmap <silent> <leader>P				"+P
vmap <silent> <leader>y				"+y
vmap <silent> <leader>Y				"+Y
vmap <silent> <leader>p				"+p
vmap <silent> <leader>P				"+P

" similar escape keybinds for terminal
tmap <C-[>							<C-W>N
tmap <C-W>p							<C-W>""

" group move lines
vmap <C-p>							:m '<-2<cr>gv=gv
vmap <C-n>							:m '>+1<cr>gv=gv
vnoremap >							>gv
vnoremap <							<gv
