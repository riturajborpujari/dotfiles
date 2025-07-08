if exists('g:loaded_wayland_clipboard')
    finish
endif
let g:loaded_wayland_clipboard = 1

nnoremap "+ "w
vnoremap "+ "w

function! s:wayland_yank()
  if v:event['regname'] == 'w' || v:event['regname'] == '+'
    silent call job_start(['wl-copy'] + ['--', getreg(v:event['regname'])], {
          \ 'in_io': 'null', 'out_io': 'null', 'err_io': 'null',
          \ 'stoponexit': '',
          \ })
  endif
endfunction

function! s:wayland_paste(p)
  silent let @w=system('wl-paste --no-newline')

  return '"w' . a:p
endfunction

augroup wayland_yank_workaround
  autocmd!
  autocmd TextYankPost * call s:wayland_yank()
augroup END

nnoremap <expr> <silent> "+p <SID>wayland_paste('p')
nnoremap <expr> <silent> "+P <SID>wayland_paste('P')
