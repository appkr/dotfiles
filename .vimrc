set nocompatible              " be iMproved, required
filetype off                  " required

"------------------------------------------------------------------------------"
" set the runtime path to include Vundle and initialize
"------------------------------------------------------------------------------"

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'jistr/vim-nerdtree-tabs'

"------------------------------------------------------------------------------"
" All of your Plugins must be added before the following line
"------------------------------------------------------------------------------"

call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------------------------"
" Plugin Settings
"------------------------------------------------------------------------------"

" CtrlP
let g:ctrlp_custom_ignore='node_modules\|DS_Store\|git' 
let g:ctrlp_match_window='top,order:ttb,min:1,max:30,results:30' 
nmap <c-E> :CtrlPMRUFiles<cr>
nmap <c-R> :CtrlPBufTag<cr>

" NerdTree
let NERDTreeHijackNetrw=0
nmap <Leader>1 :NERDTreeToggle<cr>
nmap <Leader><space> :nohlsearch<cr>

" NerdTreeTabs
map <Leader>n <plug>NERDTreeTabsToggle<cr>

" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
" let g:airline_theme='term_dark'

" GitGutter

"------------------------------------------------------------------------------"
" General
"------------------------------------------------------------------------------"

set backspace=indent,eol,start
set updatetime=250
let mapleader=','

"------------------------------------------------------------------------------"
" UI
"------------------------------------------------------------------------------"

set number
set t_CO=256
set guioptions-=e
set linespace=16
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

"colorscheme atom-dark-256
colorscheme default
syntax enable

"------------------------------------------------------------------------------"
" Mappings
"------------------------------------------------------------------------------"

nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader><space>> :nohlsearch<cr>
nmap <C-H> <C-W><C-H>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>

"------------------------------------------------------------------------------"
" Auto Commands
"------------------------------------------------------------------------------"

augroup auutosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"------------------------------------------------------------------------------"
" Tab
"------------------------------------------------------------------------------"

set smartindent
set tabstop=4
set expandtab
set shiftwidth=4

