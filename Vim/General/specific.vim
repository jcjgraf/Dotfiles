" Language Specific Settings

" Folding
au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
au FileType python set foldmethod=indent
au FileType yaml set foldmethod=indent
let g:markdown_folding = 1

" Spell correction
augroup enableSpell
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType markdown setlocal spell
    autocmd BufRead /tmp/neomutt-* setlocal spell
augroup END
