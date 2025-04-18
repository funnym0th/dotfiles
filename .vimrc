" [parameters]
set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax on
set number
set cursorline
set tabstop=4
set expandtab
set incsearch
set noshowmode
set showmatch
set hlsearch
set smartcase
set laststatus=2
set smartindent
set softtabstop=4
set wildmenu
set wrap

" [plugins]
call plug#begin()
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'itchyny/lightline.vim'
Plug 'bfrg/vim-c-cpp-modern'
Plug 'liuchengxu/graphviz.vim'
Plug 'lervag/vimtex'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-buffer-ops'
Plug 'vimsence/vimsence'
Plug 'tpope/vim-fugitive'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" [theme]
colorscheme gruvbox
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set background=dark

" [compatibility]
if (empty($TMUX) && getenv('TERM_PROGRAM') != 'Apple_Terminal')
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" [encoding]
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set encoding=utf-8

" [plugin config]
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_compiler_latexmk = {
    \ 'continuous' : 0,
    \ }
autocmd VimLeave * :DiscordDisconnect
autocmd VimEnter * :DiscordReconnect
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ 'mode_map': {
      \ 'n' : 'Normal',
      \ 'i' : 'Insert',
      \ 'R' : 'Replace',
      \ 'v' : 'Visual',
      \ 'V' : 'Visual Line',
      \ "\<C-v>": 'Visual Block',
      \ 'c' : 'Command',
      \ 's' : 'Select',
      \ 'S' : 'Select Line',
      \ "\<C-s>": 'Select Block',
      \ 't' : 'Terminal'
      \ }
      \ }
let NERDTreeShowHidden=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && !exists("s:std_in") | NERDTree | wincmd p | NERDTreeFind | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" [compilation]
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType cpp map <buffer> <F9> :w<CR>:exec '!g++ -std=c++11 -o %:r ' . shellescape(@%, 1) . ' && ./%:r'<CR>
autocmd FileType cpp imap <buffer> <F9> <esc>:w<CR>:exec '!g++ -std=c++11 -o %:r ' . shellescape(@%, 1) . ' && ./%:r'<CR>
autocmd FileType tex map <buffer> <F9> :VimtexCompile<CR>:VimtexView<CR>
autocmd FileType tex imap <buffer> <F9> <Esc>:VimtexCompile<CR>:VimtexView<CR>
autocmd FileType rust map <buffer> <F9> :w<CR>:exec '!cd $(dirname %)/../ && cargo run'<CR>
autocmd FileType rust imap <buffer> <F9> <esc>:w<CR>:exec '!cd $(dirname %)/../ && cargo run'<CR>
autocmd FileType rust map <buffer> <F5> :w<CR>:exec '!cd $(dirname %)/../ && cargo check'<CR>
autocmd FileType rust imap <buffer> <F5> <esc>:w<CR>:exec '!cd $(dirname %)/../ && cargo check'<CR>

" [editing]
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre *.bin,*.exe,*.out,*.png,*.jpg setlocal binary
    autocmd BufReadPost * if &binary | %!xxd -g 1
    autocmd BufReadPost * set ft=xxd
    autocmd BufWritePre * if &binary | %!xxd -r
    autocmd BufWritePost * if &binary | %!xxd -g 1 | set nomodified
augroup END
autocmd FileType markdown nnoremap <buffer> <F9> :.!fmt -w 115<CR>
autocmd FileType markdown inoremap <buffer> <F9> <Esc>:.!fmt -w 115<CR>
autocmd FileType cpp setlocal shiftwidth=4 tabstop=4 softtabstop=4

