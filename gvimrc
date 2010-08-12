" Example Vim graphical configuration.
" Copy to ~/.gvimrc or ~/_gvimrc.

set guifont=Monaco:h20            " Font family and font size.
winpos 0 0

set antialias                     " MacVim: smooth fonts.
set encoding=utf-8                " Use UTF-8 everywhere.
set guioptions-=T                 " Hide toolbar.
set guioptions-=L    " no scrollbars on the left
set guioptions-=r    " no scrollbars on the right
set background=light              " Background.
set lines=25 columns=100          " Window dimensions.

set cursorline                    " highlight cursorline
"
" put the * register on the system clipboard
set clipboard+=unnamed

colorscheme xoria256 
