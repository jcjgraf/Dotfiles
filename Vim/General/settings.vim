set t_Co=256            " enable 256 colors

"" Tabs and Spaces
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=4    " number of spaced per shift
set smartindent     " enable smart indentation
"autocmd FileType yaml,yml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

"" UI Visuals
set number              " show line numbers
"set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]


"" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set smartcase           " search caseinsensitive unless capital entered

"" Folding
set foldenable          " enable folding
set foldlevelstart=1    " fold everything at start
set foldmethod=syntax   " fold based on syntax
" Save folds on save and restore automatically when open file
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
" Shell foldings
au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
" Python foldings
au FileType python set foldmethod=indent
au FileType yaml set foldmethod=indent
" Markdown folding
let g:markdown_folding = 1

"" Backup
set undodir=~/.local/share/nvim/swap/undo//
set undofile
set nobackup                        " Do not create backup
set nowritebackup                   " Do not create backup
set noswapfile
" set directory=~/.local/share/nvim/swap//


"" Spell correction
" Enable for some default programs
augroup enableSpell
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType markdown setlocal spell
    autocmd BufRead /tmp/neomutt-* setlocal spell
augroup END

"" Ignore files for nerdtree and ctrlp
set wildignore+=*/.git/*,*/node_modules/*,*/__pycache__/,*/env/*,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk
