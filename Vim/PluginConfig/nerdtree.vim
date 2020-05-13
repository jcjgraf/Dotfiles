"" Nerdtree
" Open a NerdTree if no file is given as CLI argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Toggle nerdtree
nnoremap <Leader>f :NERDTreeToggle<Enter>

" Close nerdtree after opening a file
let NERDTreeQuitOnOpen = 1

" Disable help message at top
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
