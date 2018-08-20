set nocompatible              " be iMproved, required
filetype off                  " required

" Load general settings
source ~/.vim/general.vim

" Load plugins
source ~/.vim/plugins.vim

" Look and feel
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colo solarized

" Presistent undo on files"{{{
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch 
endtry
" }}}

" Set swapfile in different directory
set swapfile
set directory=~/.vim_runtime/temp_dirs/swapdir

" Autoload vimrc
augroup reload_vimrc " {{{
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END 
" }}}
