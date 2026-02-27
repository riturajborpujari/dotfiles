vim9script

def GoDoc(name: string)
	var symbol = name
	if symbol == ""
		var tmp_isk = &l:iskeyword
		setlocal iskeyword+=.
		symbol = expand("<cword>")
		&l:iskeyword = tmp_isk
	endif

	var cmd = "go doc " .. shellescape(symbol)
	var lines = systemlist(cmd)
	if v:shell_error != 0
		echohl ErrorMsg
		echom 'Command Failed: ' .. cmd
		echohl None
		return
	endif

    enew
    setlocal buftype=nofile bufhidden=wipe noswapfile
    setlocal filetype=go
	execute "file GoDoc: " .. symbol
    setline(1, lines)
    normal! gg
enddef

command! -nargs=? GoDoc call GoDoc('<args>')
