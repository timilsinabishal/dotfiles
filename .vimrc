set nocompatible              " be iMproved, required
filetype off                  " required

" Plugins "{{{
set rtp+=~/.vim/bundle/Vundle.vim " add run time path
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Utility
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

" Git integration
Plugin 'tpope/vim-fugitive'

" Programming
Plugin 'valloric/youcompleteme'
Plugin 'vim-javascript'
Plugin 'scrooloose/syntastic'

" Experimental for working with laravel
"Plugin 'Shougo/vimproc'
"Plugin 'Shougo/unite.vim'
"Plugin 'shawncplus/phpcomplete.vim'
"Plugin 'm2mdas/phpcomplete-extended'
"Plugin 'm2mdas/phpcomplete-extended-laravel'

" Color Schemes
Plugin 'altercation/vim-colors-solarized'

call vundle#end()
filetype plugin indent on

" }}}

" Nerdtree configuration "{{{
" Open NERDTree by default
autocmd vimenter * NERDTree 
" Open NERDTree if no filename specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open NERDTree when vim start ups on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close if only left window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Map to open Nerdtree
map <c-n> :NERDTreeToggle<CR>
" }}}

" Syntastic configuration "{{{
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_php_checkers = ["php", "phpcs", "phpmd"]

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" aggregate errors from all checkers for a file type
let g:syntastic_aggregate_errors = 1
" automatically open and close error list when an error is detected
let g:syntastic_always_populate_loc_list = 1
" number of lines of errors in syntastic
let g:syntastic_loc_list_height=5
" }}}

" Javascript specific "{{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" }}}

" CtrlP specific "{{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" set working directory for Ctrlp
let g:ctrlp_working_path_mode = 'ra'
" Exclude files and folder
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }
" }}}

" YouCompleteMe specific "{{{
" Close preview afer insertion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
" }}}

" Look and feel
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colo solarized

" General "{{{
inoremap jj <ESC> 
inoremap jk <ESC> 
set number "show number of line
set relativenumber "show relative number
set shiftwidth=4
set softtabstop=4
set expandtab "use space for tab
set autoindent
set smartindent

" Enable better write in readonly files
cmap w!! w !sudo tee % >/dev/null

" Enable mouse support
set mouse=a

syntax on

set incsearch "incremental search as you type
set hlsearch "hightlight search
set showmatch "show matching bracket
" This unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

set ruler "set ruler
set nowrap "disable wrapping of lines

" Use vim with clipboard support for this to work
set clipboard=unnamedplus

" Enable ignorecase when searching
set ignorecase
" Ignore case if search pattern is all lowercase
set smartcase
" Save on buffer change
set autowrite
set novisualbell
set noerrorbells

" C-h/j/k/l to move between buffers
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Easier tab navigation

" Set swapfile in different directory
set swapfile
set directory=~/.vim_runtime/temp_dirs/swapdir

" }}}

" Presistent undo on files"{{{
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch 
endtry
" }}}

" Autoload vimrc
augroup reload_vimrc " {{{
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END 
" }}}
