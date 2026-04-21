def ShellCommand()
	var cmd      = input("Shell command: ", "", "shellcmdline")
	if cmd == ""
		return
	endif
	var file     = expand("%")
	cmd			 = substitute(cmd, "%", file, "")

	var output = systemlist(cmd)
	var buf = bufadd("ShellCommand: " .. cmd)
	bufload(bufnr(buf))
	setbufvar(bufname(buf), "&buftype", "nofile")
	setbufvar(bufname(buf), "&swapfile", 0)
	setbufvar(bufname(buf), "&filetype", "shell")
	setbufvar(bufname(buf), "&textwidth", 80)
	deletebufline(buf, 1, '$')
	setbufline(buf, 1, ["Command: " .. cmd, "Output:"])
	setbufline(buf, 3, output)
	execute 'buffer ' .. bufnr(buf)
enddef

command! -nargs=0 ShellCommand call ShellCommand()
nnoremap ! :ShellCommand<CR>
