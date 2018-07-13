function! fxns#LListToggle() abort
  let buffer_count_before = s:BufferCount()
  " Location list can't be closed if there's cursor in it, so we need
  " to call lclose twice to move cursor to the main pane
  silent! lclose
  silent! lclose

  if s:BufferCount() == buffer_count_before
    silent! lopen
  endif
endfunction

function! fxns#QListToggle() abort
  let buffer_count_before = s:BufferCount()
  silent! cclose

  if s:BufferCount() == buffer_count_before
    silent! botright copen
  endif
endfunction

function! s:BufferCount() abort
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfuncti

" # Function to permanently delete views created by 'mkview'
function! fxns#DeleteView() abort
  let path = fnamemodify(bufname('%'),':p')
  " vim's odd =~ escaping for /
  let path = substitute(path, '=', '==', 'g')
  if empty($HOME)
  else
    let path = substitute(path, '^'.$HOME, '\~', '')
  endif
  let path = substitute(path, '/', '=+', 'g') . '='
  " view directory
  let path = &viewdir.'/'.path
  call delete(path)
  echo 'Deleted: '.path
endfunction

" vim:set ft=vim et sw=2:
