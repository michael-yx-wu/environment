" Be sure iTerm terminal type is xterm-256color
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

" Git message formatting
autocmd Filetype gitcommit setlocal spell textwidth=72

set modelines=0

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set scrolloff=5
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set number
set undofile

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=100
set formatoptions=qrn1
set colorcolumn=101

" File saving
nnoremap ; :
au FocusLost * :wa

" Trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Quick .vimrc editing
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/.vimrc<cr>

" Quick escape
inoremap jj <ESC>

" Split panes
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" NERDTree -- git clone https://github.com/scrooloose/nerdtree.git
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary")
    \ | q | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Solarized -- git clone git://github.com/altercation/vim-colors-solarized.git
syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Other plugins to install:
" NERDCommenter -- git clone https://github.com/scrooloose/nerdcommenter.git
" SnipMate -- git clone https://github.com/msanders/snipmate.vim.git
