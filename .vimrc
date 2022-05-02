set nocompatible              " be iMproved, required

" Load general settings
source ~/.vim/general.vim

" Load plugins
source ~/.vim/plugins.vim

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
