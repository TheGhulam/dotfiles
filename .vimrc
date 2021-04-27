" Personal preference
set shiftround
set expandtab
set colorcolumn=80
highlight ColorColumn ctermbg=233
set foldmethod=indent
set foldlevel=99

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable stupid backup and swap files
" set nobackup
" set nowritebackup
" set noswapfile

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
set clipboard=unnamed
"" set pastetoggle=<F2>

" Rebind <Leader> key
let mapleader = ","

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv


" Python
autocmd Filetype python setlocal tabstop=4
autocmd FileType python setlocal softtabstop=4
autocmd Filetype python setlocal shiftwidth=4
autocmd Filetype python setlocal expandtab
autocmd Filetype python setlocal autoindent
autocmd Filetype python setlocal fileformat=unix
let g:syntastic_python_checkers=['pep8', 'pylint', 'python']

" MIT Missing Semester settings
set nocompatible
filetype plugin on
syntax on
set shortmess+=I
set number
set relativenumber
set laststatus=2
set backspace=indent,eol,start
set hidden
set hlsearch
map <leader>h :set hlsearch!<cr>
set incsearch
set ignorecase
set smartcase
set incsearch
set noerrorbells visualbell t_vb=

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Enable mouse support
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" ~PLUGINS~
" Vim-plug
call plug#begin('~/.vim/plugged')

Plug 'gruvbox-community/gruvbox'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'vimwiki/vimwiki'

call plug#end()

" Settings for powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2

" Settings for ctrlp
let g:ctrlp_max_height = 30
" set wildignore+=*.pyc
" set wildignore+=*_build/*
" set wildignore+=*/coverage/*

" Settings for python-mode
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0

" Theme
colorscheme gruvbox
:set bg=dark
hi Normal ctermbg=none " Removing background
highlight NonText ctermbg=none
" Show whitespace (Must be inserted after? colorscheme command)
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Pathogen
execute pathogen#infect()

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
