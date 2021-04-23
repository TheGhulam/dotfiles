"##############################################################"
" vim: set foldmarker={,} foldlevel=0 foldmethod=marker :
"
" Vim Configuration
"
" Hangchen YU
"
" This is the personal Vim configuration of Hangchen YU.
"
" File: vimrc
"
"##############################################################"

" General Settings {

    " We use Vim settings
    set nocompatible        " Must be the first line

    " Load external settings
    set exrc
    " set secure

    " Set Yuhc Vim Configuration path
    let $YUPATH=$HOME."/.yuhc-vim"
    " Uncomment the next 4 lines if you use GVim in Windows
    "if has('gui_running')
    "    " Set Yuhc Vim Configuration path
    "    let $YUPATH="D:\.yuhc-vim"
    "endif

    " Disable backup
    set nobackup
    set nowritebackup

    " Set some search options
    "set incsearch
    set ignorecase
    set hlsearch
    " remap space to clear highlight
    nmap <SPACE> <SPACE>:noh<CR>

    " Spell Checking
    set spell spelllang=en_us
    "set nospell
    "set spelllang=en,es,it
    set spellsuggest=5

    " Setup Vundle Support {

        filetype off            " Required by Vundle
        "  set the runtime path to include Vundle and initialize
        set rtp+=$YUPATH/bundle/Vundle.vim
        " Uncomment this if you use GVim in Windows
        "if has('gui_running')
        "    set rtp+=D:\.yuhc-vim\bundle\Vundle.vim
        "    let path='D:\.yuhc-vim\bundle'
        "    call vundle#begin(path)
        "else
            call vundle#begin()
        "endif

        " Let Vundle manage Vundle, this is required
        Plugin 'gmarik/Vundle.vim'

    " }

" }
