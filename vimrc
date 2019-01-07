if &compatible
  set nocompatible
endif

if has('gui_running')
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

if has('mouse')
  set mouse=a
endif

set t_Co=256
set encoding=utf-8
set fileencoding=utf-8
set autoindent
set showcmd
set wildmenu
set display=truncate
set list listchars=tab:»·,trail:·
set nu " line numbers
set backspace=2
set switchbuf=usetab,newtab
set hlsearch
set laststatus=2 " open vim-airline even if there is only one split
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoread
set clipboard=unnamed " use the system clipboard

syntax on
:silent! colorscheme mustang

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab cursorcolumn

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  " Revert with ":filetype off".
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

let g:ale_open_list = 1
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']
let g:ale_fixers['typescript'] = ['tslint']

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

let g:typescript_indent_disable = 1

" ctrl+p opens fzf files
map <C-p> :Files<CR>
