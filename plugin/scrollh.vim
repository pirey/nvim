" Start horizontal scroll mode
function! StartScrollH()
  nnoremap <buffer> l zl
  nnoremap <buffer> h zh
  nnoremap <buffer> L zL
  nnoremap <buffer> H zH
  nnoremap <buffer> q :call EndScrollH()<CR>
  nnoremap <buffer> <Esc> :call EndScrollH()<CR>
  echo "-- SCROLL --"
endfunction

function! EndScrollH()
  nunmap <buffer> l
  nunmap <buffer> h
  nunmap <buffer> L
  nunmap <buffer> H
  nunmap <buffer> q
  nunmap <buffer> <Esc>
  echo ""
endfunction

nnoremap zl :call StartScrollH()<CR>
nnoremap zh :silent call StartScrollH()<CR>

