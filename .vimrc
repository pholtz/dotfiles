colorscheme nord

syntax enable  " enable syntax processing

set tabstop=4  " number of visual spaces per tab
set softtabstop=4  " number of spaces in tab when editing
set expandtab  " when you press tab, <tabstop> number of spaces are inserted

set number  " show line numbers
set showcmd  " show command in status bar

set cursorline  " highlight the current line

filetype indent on  " load filetype specific indent file

set wildmenu  " visual autocomplete for status bar

set lazyredraw  " redraw only when needed

set showmatch  " highlight matching [{()}]

set incsearch  " search as characters are entered
set hlsearch  " highlight matches

set backspace=indent,eol,start  " fix backspace issue

" nnoremap <leader><space> :nohlsearch<CR>
" nnoremap B ^
" nnoremap E $

