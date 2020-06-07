function! MakeSession(overwrite)
  let b:sessiondir = $HOME . "/.cache/vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  if a:overwrite == 0 && !empty(glob(b:filename))
    return
  endif
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.cache/vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
if(argc() == 0)
  au VimEnter * nested :call LoadSession()
  au VimLeave * :call MakeSession(1)
else
  au VimLeave * :call MakeSession(0)
endif

" Change tab size dynamically
fun! ChangeTabSize(amount)
    echo "Set tabindent to " . a:amount
    execute "set tabstop=" . a:amount
    execute "set shiftwidth=" . a:amount
    execute "set softtabstop=" . a:amount
endfun

command! -nargs=1 ChangeTabSize call ChangeTabSize(<args>)
map <Leader>t :<C-U>call ChangeTabSize(v:count)<CR>
