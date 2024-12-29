" Change tab size dynamically
fun! ChangeTabSize(amount)
    echo "Set tabindent to " . a:amount
    execute "set tabstop=" . a:amount
    execute "set shiftwidth=" . a:amount
    execute "set softtabstop=" . a:amount
endfun

command! -nargs=1 ChangeTabSize call ChangeTabSize(<args>)
map <Leader>t :<C-U>call ChangeTabSize(v:count)<CR>
