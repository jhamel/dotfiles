set nocompatible                  " Must come first because it changes other options.

silent! call pathogen#runtime_append_all_bundles()

set t_Co=256
colorscheme warmbed256 

syntax enable                     " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.rsyntax enable

set showcmd          " display incomplete commands
set showmode         " show current mode down to bottom

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set nowrap                          " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title

set visualbell                    " No beeping.

set noswapfile
set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

set isk+=_,$,@,%,#,-              " none word dividers
set mat=5                  " duration to show matching brace (1/10 sec)
" Automatic fold settings for specific files. Uncomment to use.
set foldtext=MyFoldText()
autocmd FileType ruby setlocal foldmethod=syntax foldlevel=1 foldnestmax=5
autocmd FileType css  setlocal foldmethod=indent shiftwidth=2 tabstop=2

" = keyboard mappings =

let mapleader=","    " set leader to ','

" toggle display extra whitespaces
map <Leader>lc :set list! listchars=tab:»·,trail:·<CR>

" because <C-]> on german keyboard is a impossible mission
nnoremap ü <C-]>

" toggle spellchecking by language => ",de" or ",en"
map <Leader>de :set spelllang=de<CR>:set spell! spell?<CR>
map <Leader>en :set spelllang=en<CR>:set spell! spell?<CR>

" toggle line wrapping ",w"
nmap <silent> <Leader>w :set invwrap<CR>:set wrap?<CR>
" toggle search result highlighting ",n"
nmap <silent> <Leader>n :set invhls<CR>:set hls?<CR>

" edit vim configuration ",vr"
map <Leader>vr :e $MYVIMRC<CR>
au! BufWritePost $MYVIMRC source $MYVIMRC "  source vimrc after each write
map <Leader>gr :e $MYGVIMRC<CR>

"make Y consistent with C and D
nnoremap Y y$

" switch to the last buffer used ",,"
map <leader><leader> <C-^>
" tab through buffers
map <Tab> :bn<CR>

" insert an empty line outside of insert-mode "shift-enter"
map <S-Enter> O<Esc>

" indent file (and delete trailing whitespaces)
map <silent> <Leader>i :%s/\s\+$//e<Esc>mx<Esc>gg=G<Esc>'x<ESC>
" xml indention
map <Leader>xi mx<Esc>:%s/></>\r</g<CR>gg=G<Esc>'x<Esc>
command! W :w " wurstfinger fix: :W == :w
" emacs movement keybindings in insert mode
imap <C-a> <C-o>0
imap <C-e> <C-o>$
map <C-e> $
map <C-a> 0

map <Leader>f :set fu<CR>:set co=999<CR>:set lines=999<CR>

" For the MakeGreen plugin and Ruby RSpec. Uncomment to use.
autocmd BufNewFile,BufRead *_spec.rb compiler rspec

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()

function! SetCursorPosition()
  if &filetype !~ 'commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfunction

" unaggressive folding text
function! MyFoldText()
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction

"if &term =~ "xterm"
  let &t_SI = "\<Esc>]12;purple\x7"
  let &t_EI = "\<Esc>]12;blue\x7"
"endif
