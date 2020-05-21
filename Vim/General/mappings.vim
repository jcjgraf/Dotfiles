"" Leader Shortcuts
" Change leader to comma
let mapleader=","

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
"
" Exit insert mode
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kj <Esc>
"
" Insert new line without enterint insert
nmap oo o<Esc>k
nmap OO O<Esc>j

"nmap <leader>t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
"nmap <leader>m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" turn off search highlighting
nnoremap <leader><space> :nohlsearch<CR>

" highlight last inserted text
nnoremap gV `[v`]

" Move to errors
nnoremap <leader>e :lnext<CR>
nnoremap <leader>E :lprevious<CR>

" Open and close folds
nnoremap <leader>f zA

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

"" Remove Trailing Spaces by calling `TrimWhitespaces` or using a shortcut
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()
:noremap <Leader>w :call TrimWhitespace()<CR>

"" Markdown
" pandoc , markdown
command! -nargs=* RunSilent
      \ | execute ':silent !'.'<args>'
      \ | execute ':redraw!'
nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
nmap <Leader>pp :RunSilent xdg-open /tmp/vim-pandoc-out.pdf<CR>

