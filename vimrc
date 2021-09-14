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
set number " line numbers
set backspace=2
set switchbuf=usetab,newtab
set hlsearch
"set ignorecase
set incsearch
"set noswapfile
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
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1

"let g:airline#extensions#ale#enabled = 1
"let g:ale_open_list = 1
"let g:ale_fixers = {}
"let g:ale_fixers['javascript'] = ['eslint']
"let g:ale_fixers['typescript'] = ['tslint']
""let g:ale_fixers['typescript'] = ['eslint']
"let g:ale_fix_on_save = 1
"let g:ale_lint_on_save = 1
"let g:ale_lint_on_text_changed = 0
""let b:ale_linters = ['eslint']
"let g:ale_sign_error = '✘'
"let g:ale_sign_warning = '⚠'
"highlight ALEErrorSign ctermbg=NONE ctermfg=red
"highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
"
"" let g:typescript_indent_disable = 1
"
"let g:go_highlight_functions = 1
"let g:go_highlight_methods = 1
"let g:go_highlight_structs = 1
""let g:go_def_mode='gopls'
""let g:go_info_mode='gopls'
"let g:go_def_mapping_enabled = 0
"let g:go_auto_type_info = 1
"let g:go_echo_command_info = 0

" go
" vim-go
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_structs = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go

  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>

augroup END

" ctrl+p opens fzf files
map <C-p> :Files<CR>

" first, enable status line always
set laststatus=2

set diffopt=vertical

let g:fzf_layout = { 'down': '~40%' }

"let g:user_emmet_leader_key='<C-z>'
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}
"
"autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
