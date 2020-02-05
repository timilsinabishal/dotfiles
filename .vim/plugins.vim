" To install vim plug run  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Plugins "{{{
set rtp+=/usr/local/opt/fzf
call plug#begin('~/.vim/plugged')

" Utility
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mbbill/undotree'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-sleuth' " heuristics indentation
Plug 'vim-airline/vim-airline' "also integrates with ale
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/largefile'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Languages
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  Plug 'deoplete-plugins/deoplete-jedi'
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
else
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
  " Plug 'python-mode/python-mode', { 'branch': 'develop' }
endif
Plug 'tweekmonster/django-plus.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'w0rp/ale'
Plug 'mattn/emmet-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'lumiliet/vim-twig'

" Snipplets
Plug 'SirVer/ultisnips'
" Snipplets list
Plug 'honza/vim-snippets'

" Integration with tmux
Plug 'tmux-plugins/vim-tmux-focus-events'
" Experimental for working with laravel
"Plug 'Shougo/vimproc'
"Plug 'Shougo/unite.vim'
"Plug 'shawncplus/phpcomplete.vim'
"Plug 'm2mdas/phpcomplete-extended'
"Plug 'm2mdas/phpcomplete-extended-laravel'

" Color Schemes
Plug 'altercation/vim-colors-solarized'

call plug#end()
" Automatic PlugUpgrade
delc PlugUpgrade
filetype plugin indent on

" }}}

" Neovim/vim specific "{{{
if has('nvim')
  " Required for operations modifying multiple buffers like rename.
  set hidden

  let g:LanguageClient_serverCommands = {
	\    'python': ['pyls', '-v'],
	\    'javascript': ['javascript-typescript-stdio'],
	\    'javascript.jsx': ['javascript-typescript-stdio'],
	\ }
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
else
endif
" }}}
"
" Define large file size (mb)
let g:LargeFile = 2

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
" Mirror nerdtree
autocmd BufWinEnter * NERDTreeMirror
" }}}

" Ale configuration "{{{
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['autopep8'],
\   'php': ['phpcs', 'phpmd'],
\   'scss': ['stylelint'],
\   'css': ['stylelint'],
\}

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'scss': ['stylelint'],
\   'css': ['stylelint'],
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
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
" }}}

" Deoplete "{{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#sources#ternjs#docs = 1
let g:deoplete#sources#ternjs#types = 1
let g:deoplete#sources#jedi#show_docstring = 1
let g:deoplete#sources#jedi#docs = 1
let g:jedi#smart_auto_mappings = 1
let g:deoplete#enable_auto_close_preview = 1
" close preview window on leaving the insert mode
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}

" Pythonmode specific "{{{
let g:pymode_python = 'python3'
augroup unset_folding_in_insert_mode
    autocmd!
    autocmd InsertEnter *.py setlocal foldmethod=marker
    autocmd InsertLeave *.py setlocal foldmethod=expr
augroup END
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
nnoremap <silent> <expr> <c-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Ag\<cr>"
nnoremap <silent> <expr> <c-b> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Buffers\<cr>"

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
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

map <Leader><Leader> <Plug>(easymotion-prefix)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" <leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" }}}

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Misc {{{
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" }}}
