set t_Co=256            " enable 256 colors

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

"" Leader Shortcuts
" Change leader to comma
let mapleader=","
nnoremap <leader>c :ColorToggle<CR>

"" Searching
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlighting
nnoremap <leader><space> :nohlsearch<CR>

"" Folding
set foldenable          " enable folding
set foldlevelstart=10   " open most folds by default
" open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" Save folds on save and restore automatically when open file
augroup remember_folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END

"" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" In insert or command mode, move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
" Exit insert mode
inoremap jj <Esc>
" Insert new line without enterint insert
nmap oo o<Esc>k
nmap OO O<Esc>j

" highlight last inserted text
nnoremap gV `[v`]

"" Launch Config
execute pathogen#infect()

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

"" Remove Trailing Spaces by calling `TimWhitespaces` or using a shortcut
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
:noremap <Leader>w :call TrimWhitespace()<CR>

"" Spell correction
" Enable for some default programs
augroup enableSpell
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType markdown setlocal spell
    autocmd BufRead /tmp/neomutt-* setlocal spell
augroup END
" Use vim-DetectSpellLang to detect language
let g:detectspelllang_langs = {}
let g:detectspelllang_langs.aspell = [ 'en_GB', 'de_CH' ]

syntax enable
