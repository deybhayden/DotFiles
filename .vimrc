" benjavim - step into the vimzone
" Maintainer:   Ben Hayden <https://deybhayden.me/>
" Version:      0.1

" Set script encoding
set encoding=utf-8
scriptencoding utf-8
" Set colorscheme and other UI tweaks
colorscheme solarized
if $COLORFGBG ==# '11;15'
  set background=light
else
  set background=dark
end
let g:solarized_diffmode = 'low'
" Change cursor shapes in different modes
let &t_ti = "\e[1 q"
let &t_SI = "\e[5 q"
let &t_EI = "\e[1 q"
let &t_te = "\e[0 q"
" Italic comments
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
" Set vertical split chars
set fillchars+=vert:\ 
" Configure status line
let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }
" Tell GitGutter not to change column colors
let g:gitgutter_override_sign_column_highlight = 0
" Lower updatetime for reduced latency when updating GitGutter
set updatetime=100
" Raise redrawtime for syntax highlighting large files
set redrawtime=10000
" Syntax highlighting performance changes
syntax sync minlines=256
set regexpengine=1

" Temporary files
set directory=/tmp/
" Highlight while searching
set hlsearch
set incsearch
" Be smart about case senstive searches
set ignorecase
set smartcase
" Switch buffers without saving
set hidden
" No bells
set noerrorbells visualbell t_vb=
" Mouse is okay
set mouse=a
" Share GUI clipboard
set clipboard^=unnamedplus,unnamed
" Set up fzf
if has('macunix')
  set runtimepath+=/usr/local/opt/fzf
  let g:fzf_history_dir = '~/.local/share/fzf-history'
else
  set runtimepath+=~/.fzf
endif
let g:fzf_tags_command = 'ctags -R'
" Disable autopair keybindings
let g:AutoPairsShortcutToggle = ''
let g:AutoPairsShortcutFastWrap = ''
let g:AutoPairsShortcutJump = ''
let g:AutoPairsShortcutBackInsert = ''

" Leader mappings
let g:mapleader = ','
let g:maplocalleader = '\'

" General
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>es :vsplit $HOME/.bashrc<cr>
nnoremap <leader>ef :e<space>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sp :set spell!<cr>
nnoremap <leader>sn :set number! cursorline!<cr>
nnoremap <leader>sw :set wrap!<cr>
nnoremap <leader>a ggVGy`'
nnoremap <leader>p ggVGp
nnoremap <leader>w :update<cr>
nnoremap <leader>q :qa!<cr>
nnoremap <leader>Q :wqa<cr>
nnoremap <leader>? :Helptags<cr>
nnoremap <leader>sh :helptags ALL<cr>
nnoremap <leader>l :call fxns#LListToggle()<cr>
nnoremap <leader>c :call fxns#QListToggle()<cr>
nnoremap <leader>y :let @+ = expand("%") \| echo expand("%")<cr>
" F6 is acts as an inbetween for iTerm2 and CMD+s
nnoremap <F6> :update<cr>
inoremap <F6> <C-o>:update<cr>
vnoremap <F6> <C-o>:update<cr>

" Encodings
vnoremap <leader>6 c<c-r>=system('base64 --decode', @")<cr><esc>
vnoremap <space>6 c<c-r>=system('base64', @")<cr><esc>

" Ale
nnoremap <leader>sf :ALEFix<cr>
nnoremap <leader>sF :ALEToggleFixer<cr>
nnoremap <leader>sa :ALEToggle<cr>
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_cache_executable_check_failures = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'json': ['prettier'],
\   'javascript': ['eslint', 'prettier'],
\   'css': ['eslint', 'prettier'],
\   'python': ['black']
\}
command! ALEToggleFixer execute "let g:ale_fix_on_save = get(g:, 'ale_fix_on_save', 0) ? 0 : 1"

" Cycle Autocomplete with Tab & Shift+Tab
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Buffers
nnoremap <space><tab> :b#<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>d :bd<cr>

" Commentary
nnoremap <leader>, :Commentary<cr>
vnoremap <leader>, :Commentary<cr>

" File searching
nnoremap <leader>f :FZF<cr>
nnoremap <leader>F :FZF <C-r>=expand('%:h')<cr><cr>
nnoremap <leader>r :Rg<space>
nnoremap <leader>R :Rg <C-r><C-w><cr>
nnoremap <leader>u :FZFMru<cr>
nnoremap <leader>T :Tags<cr>
nnoremap <leader>t :TagbarToggle<cr>
nnoremap <leader>gf :GFiles<cr>
nnoremap p :FZF<cr>

" Git
nnoremap <leader>gg :GitGutter<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gp :Gpush<cr>
nnoremap <leader>gb :Gblame!<cr>
vnoremap <leader>gb :Gblame!<cr>
nnoremap <leader>gl :Gbrowse!<cr>
nnoremap <leader>gL :Gbrowse<cr>
vnoremap <leader>gl :Gbrowse!<cr>
vnoremap <leader>gL :Gbrowse<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gm :Glog -- % \| Gbrowse!<cr>
nnoremap <leader>gM :Glog -- % \| Gbrowse<cr>

" Abolish
nnoremap <space>s V:S/
vnoremap <space>s :S/

" Ragtag
inoremap <C-j> <Down>
let g:ragtag_global_maps = 1

" Buf(Read|Write) Auto Commands
augroup vimrc_group
  autocmd BufWinEnter *.* silent! loadview
  autocmd BufWinLeave *.* silent! mkview
  autocmd BufWritePre *.* silent! mkview
augroup END

" Vimux
nnoremap <leader>vp :VimuxPromptCommand<cr>
nnoremap <leader>vl :VimuxRunLastCommand<CR>

" Other mappings

" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<cr>
" `gx` opens URL in web browser
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" bc (calc) operations
nnoremap <leader>= :%!bc<cr>
vnoremap <leader>= :%!bc<cr>

" Command Delview (and it's abbreviation 'delview')
command! Delview call fxns#DeleteView()
" Lower-case user commands: http://vim.wikia.com/wiki/Replace_a_builtin_command_using_cabbrev
cabbrev delview <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Delview' : 'delview')<cr>on

" vim:set ft=vim et sw=2:
