" To install vim plug run  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins "{{{
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf
call plug#begin('~/.vim/plugged')

" Utility
if has('nvim')
  Plug 'kyazdani42/nvim-tree.lua' "requires devicons
else
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
endif
Plug 'mbbill/undotree'
if has('nvim')
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim' " requires plenary
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'karb94/neoscroll.nvim' "smooth scroll
else
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
endif
Plug 'easymotion/vim-easymotion'
Plug 'ap/vim-css-color' "preview color in code
Plug 'tpope/vim-sleuth' " heuristics indentation
if has('nvim')
  Plug 'nvim-lualine/lualine.nvim' "requires devicons
  Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' } " requires devicons
  Plug 'lukas-reineke/indent-blankline.nvim' " show indentation guides
  Plug 'RRethy/vim-illuminate' " highlight word/variable references
  Plug 'kosayoda/nvim-lightbulb'
  Plug 'ThePrimeagen/refactoring.nvim'
  Plug 'akinsho/toggleterm.nvim'
  Plug 'antoinemadec/FixCursorHold.nvim'
else
  Plug 'vim-airline/vim-airline' "also integrates with ale
endif
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'vim-scripts/largefile'

" Git integration
if has('nvim')
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring' " sets commentstring according to treesitter
  Plug 'numToStr/Comment.nvim'
else
  Plug 'airblade/vim-gitgutter'
endif
Plug 'tpope/vim-fugitive'

" Track time spent
Plug 'wakatime/vim-wakatime'

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
  " LSP support
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/nvim-lsp-installer'

  "Autocompletion
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-copilot'
  Plug 'hrsh7th/nvim-cmp'

  " LuaSnip
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  Plug 'VonHeikemen/lsp-zero.nvim'

  Plug 'ray-x/lsp_signature.nvim' " Show function signatures when typing

  Plug 'github/copilot.vim'
  " Icons for autocompletion
  Plug 'onsails/lspkind.nvim'
else
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
  " Plug 'python-mode/python-mode', { 'branch': 'develop' }
endif

" Linter and fixers
if has('nvim')
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/trouble.nvim' " requires devicons

  Plug 'jose-elias-alvarez/null-ls.nvim' " requires plenary
else
  Plug 'tweekmonster/django-plus.vim'
  Plug 'pangloss/vim-javascript'
  Plug 'mxw/vim-jsx'
  Plug 'w0rp/ale'
  Plug 'lumiliet/vim-twig'
  Plug 'scrooloose/nerdcommenter'
endif
Plug 'editorconfig/editorconfig-vim'

if has('nvim')
  Plug 'rafamadriz/friendly-snippets'
else
  " Snipplets
  Plug 'SirVer/ultisnips'
  " Snipplets list
  Plug 'honza/vim-snippets'
endif

" Integration with tmux
Plug 'tmux-plugins/vim-tmux-focus-events'

" Color Schemes
if has('nvim')
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'EdenEast/nightfox.nvim'
  Plug 'navarasu/onedark.nvim'
endif
Plug 'sainnhe/sonokai'
Plug 'altercation/vim-colors-solarized'

" Syntax Highlighting
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'windwp/nvim-ts-autotag' "  autoclose and autorename html tag
endif

call plug#end()
" }}}


" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocompletion
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has('neovim')
" Javascript specific "{{{
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
set foldmethod=syntax
set foldlevelstart=99
" for jsx
let g:jsx_ext_required = 0 "allow jsx in js files
" }}}

" YouCompleteMe specific "{{{
" Close preview afer insertion
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_python_binary_path = 'python3'
let g:ycm_server_use_vim_stdout = 1
let g:ycm_server_log_level = 'debug'
" }}}

" Pythonmode specific "{{{
let g:pymode_python = 'python3'
augroup unset_folding_in_insert_mode
    autocmd!
    autocmd InsertEnter *.py setlocal foldmethod=marker
    autocmd InsertLeave *.py setlocal foldmethod=expr
augroup END
" }}}

" Snipplet specific "{{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
" }}}
endif
" LSP Neovim/vim specific "{{{
if has('nvim')
" Required for operations modifying multiple buffers like rename.  set hidden
lua << EOF
local lsp = require('lsp-zero')

lsp.preset('recommended')

-- Copilot config
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ''

-- Key mappings
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require('cmp')
local luasnip = require('luasnip')
local cmp_mapping = lsp.defaults.cmp_mappings()

cmp_mapping['<CR>'] = cmp.mapping.confirm({
  behavior = cmp.ConfirmBehavior.Replace,
  select = false
})

cmp_mapping['<Tab>'] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
        fallback()
    end
    fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
  end
end, { 'i', 's' })

cmp_mapping['<S-Tab>'] = cmp.mapping(function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end, { 'i', 's' })

local cmp_sources = {
  { name = 'path' },
  { name = 'nvim_lsp' },
  { name = 'buffer' },
  { name = 'luasnip' },
  { name = 'copilot' },
}

lsp.setup_nvim_cmp({
  completion = {
    completeopt = 'menu,menuone,noinsert,noselect'
  },
  mapping = cmp_mapping,
  sources = cmp_sources,
  formatting = {
    fields = {'abbr', 'kind', 'menu'},
    format = function(entry, item)
      local short_name = {
        nvim_lsp = '',
        nvim_lua = '',
        luasnip = '',
        buffer = '﬘',
        path = '',
        copilot = '',
      }
      local lspkind = require('lspkind')
      item.kind = string.format('%s %s', lspkind.presets.default[item.kind], item.kind)

      item.menu = short_name[entry.source.name] or entry.source.name

      return item
    end,
  }
})

-- disable tsserver formatting so it doesn't interfere null-ls
lsp.configure('tsserver', {
  flags = {
    debounce_text_changes = 150,
  },
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    require 'illuminate'.on_attach(client) -- attach vim illuminate to highlight words
  end
})
lsp.set_preferences({
  configure_diagnostics = false,
})
lsp.on_attach(function(client, bufnr)
  local noremap = {buffer = bufnr, silent=true, noremap = true}
  local bind = vim.keymap.set

  bind('n', 'mr', '<cmd>lua vim.lsp.buf.rename()<cr>', noremap)
  bind('n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', noremap)
  bind('n', '<leader>qf', '<cmd>Trouble quickfix<cr>', noremap)
  bind('n', '<leader>ll', '<cmd>Trouble loclist<cr>', noremap)
  bind('n', '<leader>ge', '<cmd>Trouble document_diagnostics<cr>', noremap)
  bind('n', 'gr', '<cmd>Trouble lsp_references<cr>', noremap)

  require('lsp_signature').on_attach();
end)
lsp.setup()

-- Setup printing of diagnostic messages {
vim.lsp.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
      virtual_text = false,
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = true,
    }
)

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Print diagnostic message as popup
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap=true, silent=true })

-- Show functions signature when typing the arguments
require('lsp_signature').setup {
  bind = true,
  floating_window = true,
}

EOF
endif
" }}}

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linters and fixers
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Editorconfig "{{{
let g:EditorConfig_exec_path = '/usr/bin/editorconfig'
" }}}

" Linting and formatting configuration "{{{
if !has('nvim')
" ALE configuration {
let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'python': ['autopep8', 'black'],
\   'php': ['phpcs', 'phpmd'],
\   'scss': ['stylelint'],
\   'css': ['stylelint'],
\}

let g:ale_linters = {
\   'javascript': ['eslint', 'prettier'],
\   'python': ['flake8', 'black'],
\   'scss': ['stylelint'],
\   'css': ['stylelint'],
\}
" Set this setting in vimrc if you want to fix files automatically on save.
" This is off by default.
let g:ale_fix_on_save = 1
let g:ale_python_black_options  = '-S'
"}
else
" NULL-LS configuration {
lua << EOF
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.formatting.eslint_d,
      null_ls.builtins.formatting.prettierd.with({
            only_local = "node_modules/.bin",
        }),
      null_ls.builtins.formatting.stylelint,
      null_ls.builtins.formatting.black,
      null_ls.builtins.formatting.autopep8,
      null_ls.builtins.diagnostics.flake8,
      null_ls.builtins.diagnostics.phpcs,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.code_actions.eslint_d,
      null_ls.builtins.code_actions.refactoring,
  },
  -- auto fix file on save
  on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
	  vim.cmd([[
	  augroup LspFormatting
	      autocmd! * <buffer>
	      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
	  augroup END
	  ]])
      end
  end,
})
EOF
endif
" }
" }}}

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Version control
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
lua << EOF
require('gitsigns').setup {
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 500,
    ignore_whitespace = false,
    },
  current_line_blame_formatter = '            <author>, <author_time:%Y-%m-%d> -- <summary>',
  current_line_blame_formatter_nc = '            <author>',
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
  end
}
EOF
else
  " Vim-gutter configuration "{{{
  set updatetime=400
  let g:gitgutter_enabled = 1
  let g:gitgutter_max_signs = 1000  " default value
  " }}}
endif

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look and feel
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Colorscheme {{{
" Change the "hint" color to the "orange" color, and make the "error" color bright red
if has('nvim')
" Themes config {
" Onedark
lua << EOF
  require('onedark').setup  {
    -- Main options --
    style = 'deep', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
  }

 -- Nightfox
  local palettes = {
    nightfox = {
      bg1 = '#171f2c', -- default #192330
    }
  }
  require("nightfox").setup({ palettes = palettes })
EOF
" Tokyonight
  let g:tokyonight_style = 'night' " storm | night

" Sonokai
  let g:sonokai_style = 'andromeda'
  let g:sonokai_better_performance = 1

" }

  " Now setup default theme
  colorscheme nightfox
endif
" }}}

" TreeSitter {{{
if has('nvim')

lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = 'all',

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "v;",
      node_incremental = ";",
      node_decremental = "'",
    },
  },
  autotag = {
    -- enable auto closing and editing of html tags
    enable = true,
  },
  -- indent based on = operator
  indent = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ib'] = '@block.inner',
        ['ab'] = '@block.outer',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  }
}
EOF

" Set foldmethod using treesitter
set foldlevel=20
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
endif
" }}}

" Statusline specific "{{{
if has('nvim')
lua << EOF
  require('lualine').setup {
  options = {
    globalstatus = false,
    theme = 'nightfox',
  },
  sections = {
      lualine_c = {{'filename', path=1}}, -- relative path
    }
  }
EOF
else
  let g:airline#extensions#ale#enabled = 1
endif
" }}}

" Bufferline specific {{{
if has('nvim')
lua << EOF
  require('bufferline').setup {
    options = {
      mode = "tabs",
      }
    }
EOF
endif
" }}}

" Show indentation guides {{{
if has('nvim')
lua << EOF
vim.opt.list = true
vim.opt.listchars:append("eol:↴")
require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
    show_end_of_line = true,
}
EOF
endif
" }}}

" Highlight references of current word {{{
" Vim illuminate specific
let g:Illuminate_ftblacklist = ['NvimTree*'] " disables for NvimTree
let g:Illuminate_delay = 100 " delay before highlight so it is disabled in fast scroll
" This is the default behaviour but copying here as we may want to change it
" later
augroup illuminate_augroup
    autocmd!
    autocmd VimEnter * hi link illuminatedWord CursorLine
augroup END
" }}}

" Auto close and rename html tags {
if has('nvim')
lua require('nvim-ts-autotag').setup()
endif
" }

" Code hints specific
" Show lightbulb icon if code actions are available
if has('nvim')
  lua vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
  lua require'nvim-lightbulb'.setup {}
endif
" }}
"
" Refactoring code
if has('nvim')
  lua require('refactoring').setup {}
endif

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
" NvimTree {{{
lua << EOF
  require'nvim-tree'.setup {
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    view = {
      number = false,
      relativenumber = false,
      hide_root_folder = false,
      mappings = {
	custom_only = false,
	list = {
	  { key = {"<CR>", "o", "<2-LeftMouse>"}, action = "edit" },
	  { key = "s", action = "vsplit" },
	  { key = "S", action = "split" },
	  { key = "t", action = "tabnew" },
	  { key = "r", action = "refresh" },
	  { key = "cd", action = "cd" },
	  { key = "ma", action = "create" },
	  { key = "mr", action = "rename" },
	  { key = "md", action = "remove" },
	  { key = "H", action = "toggle_dotfiles" },
	  { key = "I", action = "toggle_git_ignored" }
	}
      }
    },
    filters = {
      dotfiles = false,
      custom = {},
      exclude = {},
    },
    git = {
      enable = true,
      ignore = false,
      timeout = 400,
    },
  }

  -- Close NvimTree if it is the last window in the tab
  vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
      if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
	vim.cmd "quit"
      end
    end
  })
EOF
map <C-n> :NvimTreeToggle<CR>

" Show cursor when nvimtree is in focus
augroup nvim_tree_cursor
  autocmd!
  autocmd BufEnter,FileType NvimTree* set cursorline
  autocmd BufLeave,FileType NvimTree* set nocursorline
augroup END
" }}}
else
" Nerdtree configuration "{{{
" Open NERDTree by default
autocmd vimenter * NERDTree
" Open NERDTree if no filename specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Open NERDTree when vim start ups on opening a directory
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Close if only left window is NERDTree
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
" Map to open Nerdtree
map <c-n> :NERDTreeToggle<CR>
" Mirror nerdtree
autocmd BufWinEnter * NERDTreeMirror
" }}}
endif

" Easymotion Specific "{{{
let g:EasyMotion_do_mapping = 1 " Enable default mappings (is enabled by default)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

map <Leader><Leader> <Plug>(easymotion-prefix)

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)
" }}}

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search and find
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Search specific {{{
if has('nvim')
" Teleseope specific {
lua << EOF
local actions = require('telescope.actions')
require('telescope').setup {
    defaults = {
        mappings = {
            i = {
		['<esc>'] = actions.close,
                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous
            }
        }
    }
}
require('telescope').load_extension('fzf')
EOF
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope commands<cr>
nnoremap <leader>fa <cmd>lua require'telescope.builtin'.builtin{}<cr>
nnoremap <C-p> <cmd>Telescope live_grep<cr>
" }
else
"FZF specific {
nnoremap <silent> <expr> <c-p> (expand('%') =~ 'NERD_tree' ? '\<c-w>\<c-w>' : '').':Ag\<cr>'
nnoremap <silent> <expr> <c-b> (expand('%') =~ 'NERD_tree' ? '\<c-w>\<c-w>' : '').':Buffers\<cr>'

let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'
" }
endif
" }}}

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Cursorhold time
let g:cursorhold_updatetime = 500

" UndoTree specific "{{{
nnoremap U :UndotreeToggle<cr>
let g:undotree_SetFocusWhenToggle = 0
" }}}

" Trouble {{{
if has('nvim')
lua << EOF
require('trouble').setup {
  position = bottom,
  height = 5,
  auto_open = false,
  auto_close = true,
  auto_fold = true,
  mode = 'document_diagnostics', --" 'workspace_diagnostics', 'document_diagnostics', 'quickfix', 'lsp_references', 'loclist'
  action_keys = {
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh
    jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
    open_split = { "s" }, -- open buffer in new split
    open_vsplit = { "S" }, -- open buffer in new vsplit
    open_tab = { "t" }, -- open buffer in new tab
    jump_close = {"o"}, -- jump to the diagnostic and close the list
    toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = "P", -- toggle auto_preview
    hover = "K", -- opens a small popup with the full multiline message
    preview = "p", -- preview the diagnostic location
    close_folds = {"zM", "zm"}, -- close all folds
    open_folds = {"zR", "zr"}, -- open all folds
    toggle_fold = {"zA", "za"}, -- toggle fold of current file
    previous = "k", -- preview item
    next = "j" -- next item
    }
  }

vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
  {silent = true, noremap = true}
)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
  {silent = true, noremap = true}
)
EOF
" }}}

" Define large file size (mb)
let g:LargeFile = 2

" Smooth scroll {{{
lua require('neoscroll').setup()
" }}}

" Commentary {{{
lua << EOF
require('Comment').setup {
  toggler = {
    ---Line-comment toggle keymap
    line = 'gcc',
    ---Block-comment toggle keymap
    block = 'gbc',
    },
  ---LHS (left hand side) of operator-pending mappings in NORMAL + VISUAL mode
  ---@type table
  opleader = {
    ---Line-comment keymap
    line = 'gc',
    ---Block-comment keymap
    block = 'gb',
    },

  ---LHS of extra mappings
  ---@type table
  extra = {
    ---Add comment on the line above
    above = 'gcO',
    ---Add comment on the line below
    below = 'gco',
    ---Add comment at the end of line
    eol = 'gcA',
    }
  }
EOF
" }}}

" Toggleterm {{{
lua << EOF
require("toggleterm").setup {
  open_mapping = [[<c-\>]],
  direction = 'vertical',
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.3
    end
  end
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead else use *
vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')

-- Lazygit terminal {
local Terminal  = require('toggleterm.terminal').Terminal
local on_term_open = function(term)
    vim.cmd('startinsert!')
    vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', {noremap = true, silent = true})
  end

local lazygit = Terminal:new({
  cmd = 'lazygit',
  dir = 'git_dir',
  direction = 'float',
  float_opts = {
    border = 'double',
  },
  -- function to run on opening the terminal
  on_open = on_term_open
  })

local htop = Terminal:new({ cmd = 'htop', direction='float', on_open = on_term_open })

function _lazygit_toggle()
  lazygit:toggle()
end
function _htop_toggle()
  htop:toggle()
end

vim.api.nvim_set_keymap('n', '<leader>lg', '<cmd>lua _lazygit_toggle()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>ht', '<cmd>lua _htop_toggle()<CR>', {noremap = true, silent = true})
-- }
EOF
" }}}
endif
