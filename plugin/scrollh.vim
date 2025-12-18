if exists('g:loaded_scrollh')
  finish
endif
let g:loaded_scrollh = 1

" Default keybindings
if !exists('g:scrollh_right_key')
  let g:scrollh_right_key = 'l'
endif
if !exists('g:scrollh_left_key')
  let g:scrollh_left_key = 'h'
endif
if !exists('g:scrollh_right_big_key')
  let g:scrollh_right_big_key = 'L'
endif
if !exists('g:scrollh_left_big_key')
  let g:scrollh_left_big_key = 'H'
endif
if !exists('g:scrollh_quit_key')
  let g:scrollh_quit_key = 'q'
endif
if !exists('g:scrollh_escape_key')
  let g:scrollh_escape_key = '<Esc>'
endif

" Start horizontal scroll mode
function! StartScrollH()
  execute 'nnoremap <buffer> ' . g:scrollh_right_key . ' zl'
  execute 'nnoremap <buffer> ' . g:scrollh_left_key . ' zh'
  execute 'nnoremap <buffer> ' . g:scrollh_right_big_key . ' zL'
  execute 'nnoremap <buffer> ' . g:scrollh_left_big_key . ' zH'
  execute 'nnoremap <buffer> ' . g:scrollh_quit_key . ' :call EndScrollH()<CR>'
  execute 'nnoremap <buffer> ' . g:scrollh_escape_key . ' :call EndScrollH()<CR>'
  augroup ScrollHWinLeave
    autocmd! * <buffer>
    autocmd WinLeave <buffer> call EndScrollH()
  augroup END
  echo "-- SCROLL --"
endfunction

function! EndScrollH()
  execute 'nunmap <buffer> ' . g:scrollh_right_key
  execute 'nunmap <buffer> ' . g:scrollh_left_key
  execute 'nunmap <buffer> ' . g:scrollh_right_big_key
  execute 'nunmap <buffer> ' . g:scrollh_left_big_key
  execute 'nunmap <buffer> ' . g:scrollh_quit_key
  execute 'nunmap <buffer> ' . g:scrollh_escape_key
  augroup ScrollHWinLeave
    autocmd! * <buffer>
  augroup END
  echo ""
endfunction

nnoremap zl :call StartScrollH()<CR>
nnoremap zh :silent call StartScrollH()<CR>

