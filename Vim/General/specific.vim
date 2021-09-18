" Language Specific Settings

" Folding
augroup fold
    au FileType sh set foldmethod=indent
    au FileType python set foldmethod=indent
    au FileType haskell set foldmethod=indent
    au FileType yaml set foldmethod=indent
    let g:markdown_folding = 1
augroup END

" Spell correction
augroup enableSpell
    autocmd!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType markdown setlocal spell
    autocmd FileType tex setlocal spell
augroup END

" Detect .h as C
augroup project
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END

" Mutt
augroup mutt
    autocmd!
    autocmd BufRead /tmp/neomutt-* setlocal spell
"    autocmd BufRead /tmp/neomutt-* setlocal fo+=a  " Auto linebreak
augroup END
