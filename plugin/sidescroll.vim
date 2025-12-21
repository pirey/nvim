if exists('g:loaded_sidescroll')
  finish
endif
let g:loaded_sidescroll = 1

" Default keybindings
if !exists('g:sidescroll_right_key')
  let g:sidescroll_right_key = 'l'
endif
if !exists('g:sidescroll_left_key')
  let g:sidescroll_left_key = 'h'
endif
if !exists('g:sidescroll_right_big_key')
  let g:sidescroll_right_big_key = 'L'
endif
if !exists('g:sidescroll_left_big_key')
  let g:sidescroll_left_big_key = 'H'
endif
if !exists('g:sidescroll_quit_key')
  let g:sidescroll_quit_key = 'q'
endif
if !exists('g:sidescroll_escape_key')
  let g:sidescroll_escape_key = '<Esc>'
endif

" Start horizontal scroll mode
function! StartSideScrollMode()
  execute 'nnoremap <buffer> ' . g:sidescroll_right_key . ' zl'
  execute 'nnoremap <buffer> ' . g:sidescroll_left_key . ' zh'
  execute 'nnoremap <buffer> ' . g:sidescroll_right_big_key . ' zL'
  execute 'nnoremap <buffer> ' . g:sidescroll_left_big_key . ' zH'
  execute 'nnoremap <buffer> ' . g:sidescroll_quit_key . ' :call EndSideScrollMode()<CR>'
  execute 'nnoremap <buffer> ' . g:sidescroll_escape_key . ' :call EndSideScrollMode()<CR>'
  augroup SideScrollWinLeave
    autocmd! * <buffer>
    autocmd WinLeave <buffer> call EndSideScrollMode()
  augroup END
  echohl ModeMsg
  echo "-- SCROLL --"
  echohl None
endfunction

function! EndSideScrollMode()
  execute 'nunmap <buffer> ' . g:sidescroll_right_key
  execute 'nunmap <buffer> ' . g:sidescroll_left_key
  execute 'nunmap <buffer> ' . g:sidescroll_right_big_key
  execute 'nunmap <buffer> ' . g:sidescroll_left_big_key
  execute 'nunmap <buffer> ' . g:sidescroll_quit_key
  execute 'nunmap <buffer> ' . g:sidescroll_escape_key
  augroup SideScrollWinLeave
    autocmd! * <buffer>
  augroup END
  echo ""
endfunction

nnoremap zl :call StartSideScrollMode()<CR>
nnoremap zh :silent call StartSideScrollMode()<CR>

