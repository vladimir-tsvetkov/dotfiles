" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug 'w0rp/ale'

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'carlitux/deoplete-ternjs'

Plug 'flowtype/vim-flow'

" Initialize plugin system
call plug#end()

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

set encoding=utf8

" Appearance
set t_Co=256
set hlsearch
set number
set relativenumber
set list
set listchars=tab:▸\ ,eol:¬
set cursorline
syntax on

" Color scheme
colorscheme gruvbox
set background=dark

" Indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Indicate the end boundary of a change
set cpoptions+=$

" Disable swapfile and backup
set nobackup
set noswapfile

" Toggle NERDTree on F3
autocmd VimEnter * nmap <F3> :NERDTreeToggle<CR>
autocmd VimEnter * imap <F3> <Esc>:NERDTreeToggle<CR>a
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=35

" Allow backspace over anything in INSERT-mode
set backspace=indent,eol,start

" Use deoplete
let g:deoplete#sources#ternjs#timeout=1
let g:deoplete#enable_at_startup=1
let g:deoplete#sources#ternjs#types=1
let g:deoplete#sources#ternjs#docs=0
let g:deoplete#sources#ternjs#include_keywords=1
let g:deoplete#sources#ternjs#filetypes=[
\   'jsx',
\]

" Close preview window on
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" ALE settings
let g:ale_linters={
\   'scala': ['fsc', 'scala', 'scalastyle'],
\   'javascript': ['eslint', 'flow'],
\}
let g:ale_scalastyle_config_loc = '/usr/local/etc/scalastyle_config.xml'
let g:ale_fixers={
\   'javascript': ['eslint'],
\}
let g:ale_sign_error='●'
let g:ale_sign_warning='●'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
noremap <F4> :ALEFix<CR>  

let g:ale_c_gcc_options='-std=c11 -Wall'
let g:ale_c_clang_options='-std=c11 -Wall -Wno-nullability-completeness'
let g:ale_asm_gcc_executable='powerpc-elf-gcc'

" CtrlP configuration
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" Enable vim-autoformat for Scala
" function! StartNailgunScalafmt()
"     silent execute '!scalafmt_ng 2>/dev/null 1>/dev/null &'
"     sleep 1
"     silent execute '!ng ng-alias scalafmt org.scalafmt.cli.Cli'
"     execute(':redraw!')
" endfunction

" call StartNailgunScalafmt()

" noremap <F5> :Autoformat<CR>
" let g:autoformat_verbosemode=1
" let g:formatdef_scalafmt = "'ng scalafmt --stdin'"
" let g:formatters_scala = ['scalafmt']
" let g:formatters_sbt = ['scalafmt']

noremap <F5> !scalafmt -i -f %<CR>

" Deactivate SQL completion on insert mode
let g:omni_sql_no_default_maps=1

" Mappings to move arround visual selection
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
inoremap <M-j> <Esc>:m .+1<CR>==gi
inoremap <M-k> <Esc>:m .-2<CR>==gi
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
