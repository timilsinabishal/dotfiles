if has('python3')
  silent! python3 1
endif
" General "{{{
inoremap jj <ESC>
inoremap jk <ESC>
let mapleader = "\<Space>"
set number "show number of line
set relativenumber "show relative number
set shiftwidth=2
set softtabstop=2
set expandtab "use space for tab
set autoindent
set smartindent

" Enable detect of file change outside of vim
set autoread
au FocusGained,BufEnter * :checktime

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
if system('uname -s') == "Darwin\n"
  "OSX
  set clipboard=unnamed
  :autocmd BufEnter *.png,*.jpg,*gif exec "! ~/.iterm2/imgcat ".expand("%") | :bw
else
  "Linux
  set clipboard=unnamedplus
endif

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

map <leader>p :bprevious<CR>
map <leader>n :bnext<CR>
nnoremap t gt
nnoremap T gT

" Easier tab navigation

" }}}

" Auto reload vimrc on change
autocmd! BufWritePost .vimrc source %
