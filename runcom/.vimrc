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

" ALE settings
let g:ale_linters={
\   'scala': ['fsc', 'scala', 'scalastyle'],
\   'javascript': ['eslint'],
\}
let g:ale_fixers={
\   'javascript': ['eslint'],
\}
let g:ale_sign_error='●'
let g:ale_sign_warning='●'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
noremap <F4> :ALEFix<CR>  

" CtrlP configuration
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" enable vim-autoformat for Scala
function! StartNailgunScalafmt()
    silent execute '!scalafmt_ng 2>/dev/null 1>/dev/null &'
    sleep 1
    silent execute '!ng ng-alias scalafmt org.scalafmt.cli.Cli'
    execute(':redraw!')
endfunction

call StartNailgunScalafmt()

noremap <F5> :Autoformat<CR>
"let g:autoformat_verbosemode=1
let g:formatdef_scalafmt = "'ng scalafmt --stdin'"
let g:formatters_scala = ['scalafmt']
