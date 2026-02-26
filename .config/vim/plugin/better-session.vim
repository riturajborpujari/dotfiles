let s:current_session = ""
let s:state_dir = $HOME . '/.local/var/vim/better-sessions'

" Ensure the state dir exists (UNIX-only fallback)
function! s:EnsureStateDir()
  if !isdirectory(s:state_dir)
    call mkdir(s:state_dir, 'p')
  endif
endfunction

" Generate session names (no extension)
function! s:SessionList(A, L, P)
  let l:globpath = s:state_dir . '/*.vim'
  let l:files = split(glob(globpath), '\n')
  return map(l:files, { _, f -> fnamemodify(f, ':t:r') })
endfunction

" Save session + viminfo
command! -nargs=? -complete=customlist,s:SessionList SessionSave call s:SessionSave(<f-args>)
function! s:SessionSave(...) abort
  call s:EnsureStateDir()

  if a:0 == 0 && empty(s:current_session)
    echom 'BetterSession: name is required'
    return
  endif
  let l:name = a:0 > 0 ? a:1 : s:current_session
  let s:current_session = l:name

  let l:session = s:state_dir . '/' . l:name . '.vim'
  let l:viminfo = s:state_dir . '/' . l:name . '.viminfo'
  execute 'mksession!' fnameescape(l:session)
  execute 'wviminfo!' fnameescape(l:viminfo)
  echom 'BetterSession: ' . l:name .' saved!'
endfunction

" Load session + viminfo
command! -nargs=1 -complete=customlist,s:SessionList SessionLoad call s:SessionLoad(<f-args>)
function! s:SessionLoad(name)
  let l:session = s:state_dir . '/' . a:name . '.vim'
  let l:viminfo = s:state_dir . '/' . a:name . '.viminfo'
  if filereadable(l:session)
    execute 'source' fnameescape(l:session)
  else
    echom 'BetterSession: ' . a:name . ': Not found'
  endif
  if filereadable(l:viminfo)
    execute 'rviminfo!' fnameescape(l:viminfo)
  else
    echom 'No viminfo found for: ' . a:name
  endif

  let s:current_session = a:name
endfunction
