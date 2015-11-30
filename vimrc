set nocompatible              " be iMproved, required
filetype off                  " required
set t_Co=256

"" powerline conf
"set guifont=Inconsolata\ for\ Powerline:h16
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set term=screen-256color
set termencoding=utf-8

"" rust highlighting
au BufNewFile,BufRead *.rs set filetype=rust
"" go highlighting
au BufNewFile,BufRead *.go set filetype=go
"" es6 support
autocmd BufRead,BufNewFile *.es6 setfiletype javascript

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/syntastic.git'
Plugin 'bling/vim-airline'
Plugin 'kien/ctrlp.vim'
Plugin 'pangloss/vim-javascript',
Plugin 'mxw/vim-jsx',
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'wting/rust.vim'
Plugin 'digitaltoad/vim-jade'
Plugin 'croaker/mustang-vim'
Plugin 'jason0x43/vim-js-indent'
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
:silent! colorscheme mustang
set t_ut=   " for tmux

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null
cmap Tabe tabe

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['jscs', 'jshint']
let g:syntastic_check_on_open = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_jump = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

let g:ctrlp_show_hidden = 1

let g:jsx_ext_required = 0  "syntax highlighting in .js files too

set smartindent
set tabstop=4
set list listchars=tab:»·,trail:·
set nu " line numbers
set backspace=2 " make backspace work like most other apps
set clipboard=unnamed   " use the system clipboard
set softtabstop=4 " backspace delete 4 spaces
set shiftwidth=4
set expandtab
set switchbuf=usetab,newtab
set hlsearch
set laststatus=2 " open vim-airline even if there is only one split
