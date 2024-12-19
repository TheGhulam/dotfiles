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
set noerrorbells visualbell t_vb=

set shiftround
set expandtab
set colorcolumn=80
highlight ColorColumn ctermbg=233
set foldmethod=indent
set foldlevel=99
let mapleader=","

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Disable stupid backup and swap files
set nobackup
set nowritebackup
set noswapfile

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Ctrl + S to save
" https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s#3448551
noremap <silent> <C-S>          :update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Leader + o/O for inserting new line without going in insert mode
" https://vi.stackexchange.com/questions/3875/how-to-insert-a-newline-without-leaving-normal-mode
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Better copy & paste
set clipboard=unnamed
set pastetoggle=<F2>

" Rebind <Leader> key
" let mapleader = ","

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
vnoremap < <gv
vnoremap > >gv


" Python
autocmd FileType python setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType python setlocal autoindent
autocmd FileType python setlocal fileformat=unix
autocmd BufNewfile *.py call append(0,'#! /usr/bin/env python')
map <C-1> :w<CR>:!python3 %<CR>

" C++
autocmd FileType cpp setlocal expandtab tabstop=2 shiftwidth=2

" HTML
" ts = 'number of spaces that <Tab> in file uses'
" sts = 'number of spaces that <Tab> uses while editing'
" sw = 'number of spaces to use for (auto)indent step'
autocmd FileType html setlocal ts=2 sts=2 sw=2

" JavaScript
autocmd FileType javascript setlocal ts=4 sts=4 sw=4

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Enable mouse support
set mouse+=a


autocmd FileType python map <buffer> <C-b> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <C-b> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" ~PLUGINS~
" Vim-plug
call plug#begin('~/.vim/plugged')

Plug 'tomtom/tcomment_vim'
Plug 'gruvbox-community/gruvbox'
Plug 'vimwiki/vimwiki'
Plug 'alvan/vim-closetag'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()


"" Plugin config

"-> NERDTree
inoremap <c-t> <Esc>:NERDTreeToggle<cr>
nnoremap <c-t> <Esc>:NERDTreeToggle<cr>

"-> Prettier (for JS, TS, CSS, JSON) config
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"" Settings for powerline
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup
" set laststatus=2

"" Theme
colorscheme gruvbox
:set bg=dark
hi Normal ctermbg=none " Removing background
highlight NonText ctermbg=none

"" Whitespace
" Show whitespace (Must be inserted after? colorscheme command)
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/
" Delete trailing whitespace
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
