set guioptions=
if has('macunix')
  set guifont=FiraMono-Regular:h13:b:i
endif

if has("gui_macvim")
  let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'StatusLine'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
  macmenu File.Print key=<nop>
  nnoremap <D-p> :FZF<cr>
  nnoremap <D-/> :Commentary<cr>
  vnoremap <D-/> :Commentary<cr>
endif

" vim:set ft=vim et sw=2:
