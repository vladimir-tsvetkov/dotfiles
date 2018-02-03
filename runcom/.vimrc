" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
" Plug 'wincent/command-t'

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

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0

let g:syntastic_scala_checkers=['fsc', 'scalac', 'scalastyle']
let g:syntastic_scala_scalastyle_jar='/usr/local/Cellar/scalastyle/0.8.0/libexec/scalastyle_2.11-0.8.0-batch.jar'
let g:syntastic_scala_scalastyle_config_file='/usr/local/etc/scalastyle_config.xml' 

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <F4> :SyntasticCheck<CR>

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
