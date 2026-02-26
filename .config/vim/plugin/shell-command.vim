nnoremap ! :call NetrwBang()<CR>
function! NetrwBang()
	let l:file     = expand("<cfile>:p")
	let l:filename = expand("<cfile>")
	let l:cmd      = input("Shell command(" .. l:filename .. "): ")
	if empty(l:cmd)
		return
	endif
	execute "!" .. l:cmd .. " " .. shellescape(l:file)
endfunction
