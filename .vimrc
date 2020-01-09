syntax enable           " enable syntax processing

"" Tabs and Spaces
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=4    " number of spaced per shift

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
" turn off search highlighting
nnoremap <leader><space> :nohlsearch<CR>

"" Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
" open/closes folds
"nnoremap <space> za
set foldmethod=indent   " fold based on indent level

"" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" highlight last inserted text
nnoremap gV `[v`]

"" Leader Shortcuts
" Change leader to comma
let mapleader=","
" save session
nnoremap <leader>s :mksession<CR>

"" Launch Config
call pathogen#infect()                      " use pathogen
"call pathogen#runtime_append_all_bundles()  " use pathogen

"" Backup
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

"" Markdown
" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nmap <Leader>pp :RunSilent xdg-open /tmp/vim-pandoc-out.pdf<CR>

"" Remove Trailing Spaces at Save
autocmd BufWritePre * %s/\s\+$//e
