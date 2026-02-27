vim9script

def HasStagedChanges(): bool
	var lines = systemlist('git diff --cached --name-only')
	return len(lines) > 0
enddef

def GitCommit()
	if !HasStagedChanges()
		echohl ErrorMsg
		echom 'No staged changes to commit'
		echohl None
		return
	endif

	OpenScratch('GitCommit', "acwrite")

	setlocal filetype=gitcommit
	setlocal modifiable

	setline(1, [
		"# Please enter the commit message for your changes. Lines starting",
		"# with '#' will be ignored, and an empty message aborts the commit.",
		"#"
	])
	
	# remove comment lines on commit
	autocmd BufWriteCmd <buffer> CommitBufferWrite()
enddef

def CommitBufferWrite()
	# Filter out comment lines
	var lines = getline(1, '$')
	var filtered: list<string> = []

	for l in lines
		if l !~ '^#'
			add(filtered, l)
		endif
	endfor

	if len(filtered) == 0
		echohl ErrorMsg
		echom 'Empty commit message'
		echohl None
		return
	endif

	var tmp = tempname()
	writefile(filtered, tmp)

	var out = systemlist('git commit -F ' .. shellescape(tmp))
	delete(tmp)

	if v:shell_error != 0
		echohl ErrorMsg
		echom join(out, "\n")
		echohl None
		return
	endif

	bwipeout!
	GitStatus()
enddef

def OpenScratch(name: string, bufType: string = "nofile")
	enew

	&l:buftype = bufType #'setlocal buftype=bufType' doesn't work
	setlocal bufhidden=wipe
	setlocal noswapfile
	setlocal nobuflisted
	setlocal nowrap
	setlocal modifiable

	execute 'file ' .. name
enddef


def ReplaceBuffer(lines: list<string>)
	setlocal modifiable
	deletebufline(bufnr(), 1, '$')
	if len(lines) > 0
		setline(1, lines)
	endif
	setlocal nomodifiable
enddef


def GetFileUnderCursor(): string
	var line = getline('.')
	if line == ''
		return ''
	endif

	if len(line) < 4
		return ''
	endif

	return trim(line[3 : ])
enddef

def Stage()
	var file = GetFileUnderCursor()
	if file == ''
		return
	endif

	system('git add ' .. shellescape(file))
	GitStatus()
enddef

def Unstage()
	var file = GetFileUnderCursor()
	if file == ''
		return
	endif

	system('git restore --staged ' .. shellescape(file))
	GitStatus()
enddef


def GitDiff()
	var file = GetFileUnderCursor()
	if file == ''
		return
	endif

	var diff = systemlist('git diff ' .. shellescape(file))
	if v:shell_error != 0
		echohl ErrorMsg
		echom 'Failed to run git diff'
		echohl None
		return
	endif

	OpenScratch('GitDiff: ' .. file)
	ReplaceBuffer(diff)
	setlocal filetype=diff
enddef

def SetupStatusMappings()
	nnoremap <buffer> s  <ScriptCmd>Stage()<CR>
	nnoremap <buffer> u  <ScriptCmd>Unstage()<CR>
	nnoremap <buffer> r  <ScriptCmd>GitStatus()<CR>
	nnoremap <buffer> c  <ScriptCmd>GitCommit()<CR>
	nnoremap <buffer> <CR> <ScriptCmd>GitDiff()<CR>
enddef


def GitStatus()
	var lines = systemlist('git status --porcelain')

	if v:shell_error != 0
		echohl ErrorMsg
		echom 'Not a git repository?'
		echohl None
		return
	endif

	if len(lines) == 0
		lines = [
			"Branch: " .. system('git branch --show-current')->trim(),
			"",
			"Working tree clean"
		]
	endif

	OpenScratch('GitStatus')
	ReplaceBuffer(lines)
	SetupStatusMappings()
enddef

command! GitStatus GitStatus()
