if exists('g:loaded_wayland_clipboard')
    finish
endif
let g:loaded_wayland_clipboard = 1

nnoremap "+ "w
vnoremap "+ "w

function! s:wayland_yank()
  if v:event['regname'] = 'w' || v:event['regname'] = '+'
    silent call job_start(['wl-copy'] + s:copy_args + ['--', getreg(v:event['regname'])], {
          \ 'in_io': 'null', 'out_io': 'null', 'err_io': 'null',
          \ 'stoponexit': '',
          \ })
  endif
endfunction

augroup wayland_yank_workaround
  autocmd!
  autocmd TextYankPost * call s:wayland_yank()
augroup END
