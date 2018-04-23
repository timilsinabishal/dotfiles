" Plugins "{{{
set rtp+=~/.vim/bundle/Vundle.vim " add run time path
set rtp+=/usr/local/opt/fzf
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Utility
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kien/ctrlp.vim'
Plugin 'mbbill/undotree'
Plugin 'junegunn/fzf.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-sleuth' " heuristics indentation
Plugin 'vim-airline/vim-airline' "also integrates with ale
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'

" Git integration
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Languages
Plugin 'valloric/youcompleteme'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'w0rp/ale'
Plugin 'mattn/emmet-vim'
Plugin 'editorconfig/editorconfig-vim'

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
set updatetime=400
let g:gitgutter_enabled = 1
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
"t g:ycm_autoclose_preview_window_after_insertion = 1
"t g:ycm_autoclose_preview_window_after_completion = 1
" }}}

" UltiSnipplet specific "{{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" }}}

" UndoTree specific "{{{
nnoremap <c-t> :UndotreeToggle<cr>
" }}}

"FZF specific "{{{
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" }}}

" Easymotion Specific "{{{
let g:EasyMotion_do_mapping = 1 " Enable default mappings (is enabled by default)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

map <leader><leader> <Plug>(easymotion-prefix)

" <leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)

" s{char}{char} to move to {char}{char}
nmap <leader>s <Plug>(easymotion-overwin-f2)
" }}}
