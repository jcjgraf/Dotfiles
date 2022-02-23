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
    autocmd BufRead /tmp/neomutt-* setlocal fo+=a  " Auto linebreak
    autocmd BufRead /tmp/neomutt-* setlocal tw=80  " Wrap after 80 chars
augroup END

" Opam/Merlin
augroup ocaml
    autocmd!
    au FileType ocaml set foldmethod=indent
    au FileType ocaml set tabstop=2
    au FileType ocaml set shiftwidth=2
    au FileType ocaml set softtabstop=2
augroup END
let g:opamshare = substitute(system('opam var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
