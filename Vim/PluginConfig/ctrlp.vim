"" CtrlP Config
" Search directory will be set to nearest anchestor og .git and cwd
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_cachint = 0

"" Ignore files for nerdtree and ctrlp
set wildignore+=*/.git/*,*/node_modules/*,*/__pycache__/,*/env/*,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls,*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk
