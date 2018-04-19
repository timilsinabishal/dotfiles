" Plugins "{{{
set rtp+=~/.vim/bundle/Vundle.vim " add run time path
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Utility
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kien/ctrlp.vim'

" Git integration
Plugin 'tpope/vim-fugitive'

" Programming
Plugin 'valloric/youcompleteme'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
"Plugin 'scrooloose/syntastic'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline' "also integrates with ale
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'

" Snipplets
Plugin 'SirVer/ultisnips'
" Snipplets list
Plugin 'honza/vim-snippets'

" Integration with tmux
Plugin 'tmux-plugins/vim-tmux-focus-events'

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


" Vim-gutter configuration "{{{
let g:gitgutter_max_signs = 1000  " default value
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

" Ale configuration "{{{
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['pylint'],
\   'php': ['phpcs', 'phpmd']
\}

" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

" }}}

" Vim airline configuration "{{{
" }}}

" Syntastic configuration "{{{
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_php_checkers = ["php", "phpcs", "phpmd"]
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"
"" aggregate errors from all checkers for a file type
"let g:syntastic_aggregate_errors = 1
"" automatically open and close error list when an error is detected
"let g:syntastic_always_populate_loc_list = 1
"" number of lines of errors in syntastic
"let g:syntastic_loc_list_height=5
" }}}
"
" Editorconfig "{{{
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
" }}}

" Javascript specific "{{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
set foldmethod=syntax
set foldlevelstart=99
" for jsx
let g:jsx_ext_required = 0 "allow jsx in js files
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

" UltiSnipplet specific "{{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-o>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}
