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

" Filetype specific plugin and intent
filetype plugin indent on

" Enable detect of file change outside of vim
set autoread
au FocusGained,BufEnter * :checktime

" Enable better write in readonly files
cmap w!! w !sudo tee % >/dev/null

" Enable mouse support
set mouse=a

" Turn syntax highlighting on.
syntax on

set incsearch "incremental search as you type
set hlsearch "hightlight search
set showmatch "show matching bracket
" This unsets the last search pattern register by hitting return
nnoremap <CR> :noh<CR><CR>

set ruler "set ruler
set nowrap "disable wrapping of lines

set cursorline " highlight cursorline

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

" Enable 256 colors in vim
set t_Co=256
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm

if has('termguicolors')
  set termguicolors
endif

" Splitting a window will put the new window below the current one.
set splitbelow

" Splitting a window will put the new window right of the current one.
set splitright

set history=100 "increase history
" Enable the marker method of folding.
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Set zsh as terminal emulator
set shell=/usr/local/bin/zsh
