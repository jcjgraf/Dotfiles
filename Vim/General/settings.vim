syntax enable                               " enable syntax highlighting
set t_Co=256                                " enable 256 colors
set tabstop=4                               " number of visual spaces per TAB
set softtabstop=4                           " number of spaces in tab when editing
set expandtab                               " tabs are spaces
set shiftwidth=4                            " number of spaced per shift
set smartindent                             " enable smart indentation
set number                                  " show line numbers
set cursorline                              " Highlight current line
set wildmenu                                " visual autocomplete for command menu
set lazyredraw                              " redraw only when we need to.
set showmatch                               " highlight matching [{()}]
set incsearch                               " search as characters are entered
set hlsearch                                " highlight matches
set smartcase                               " search caseinsensitive unless capital entered
set foldenable                              " enable folding
set foldlevelstart=20                       " fold everything at start
set foldmethod=syntax                       " fold based on syntax
set undodir=~/.local/share/nvim/swap/undo// " Set undo directory
set undofile                                " Enable write undo file
set nobackup                                " Do not create backup
set nowritebackup                           " Do not create backup
set noswapfile
" set directory=~/.local/share/nvim/swap//
set shortmess+=c                            " Don't pass messages to |ins-completion-menu|
set cmdheight=2                             " Always display the cmd
set updatetime=300                          " Shorter updatetime for shorter delay
set guicursor=                              " Disable cursor chaning to a pipe in inset
set scrolloff=3                             " Keep 3 lines below and above the cursor
set foldmethod=manual                       " Manual fold as default, overwrite for specific types

" Save folds on save and restore automatically when open file
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent! loadview
"augroup END

"" Ignore files for nerdtree and ctrlp
set wildignore+=*/.git/*,*/node_modules/*,*/__pycache__/,*/env/*,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk
