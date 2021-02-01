" Load colors from xresources
hi User1 ctermbg=1 ctermfg=15
hi User2 ctermbg=2 ctermfg=15
hi User3 ctermbg=3 ctermfg=15
hi User4 ctermbg=4 ctermfg=15
hi User5 ctermbg=5 ctermfg=15
hi User6 ctermbg=6 ctermfg=15
hi User7 ctermbg=7 ctermfg=15
hi User8 ctermbg=8 ctermfg=4

"" Cursor
hi CursorLine cterm=NONE ctermbg=8

"" Linenumber
hi LineNr ctermfg=4
hi CursorLineNr ctermfg=3

"" Statusline
let g:currentMode = {
      \ 'n':	    'Normal',
      \ 'no':	    'Operator Pending',
      \ 'v':	    'Visual char',
      \	'V':	    'Visual line',
	  \	"\<C-V>":	'Visual blck',
	  \	's':	    'Select char',
	  \	'S':	    'Select line',
	  \	"\<C-S":    'Select blck',
	  \	'i':	    'Insert',
	  \	'R':	    'Replace |R|',
	  \	'Rv':	    'Virtual Replace |gR|',
	  \	'c':	    'Command',
	  \	'cv':	    'Vim Ex mode |gQ|',
	  \	'ce':	    'Normal Ex mode |Q|',
	  \	'r':	    'Hit-enter prompt',
	  \	'rm':	    'The -- more -- prompt',
	  \	'r?':	    'A |:confirm| query of some sort',
	  \	'!':	    'Shell or external command is executing'
      \}

hi StatusLine ctermbg=15 ctermfg=8
hi StatusLineNC ctermbg=15 ctermfg=8

set statusline=
set statusline+=%4*\ %12(%{toupper(g:currentMode[mode()])}\ %)%* " Mode
set statusline+=\ ->\ %f                                         " Filename
set statusline+=\ %8*%m%*                                        " Display modified marker
set statusline+=%=                                               " Begin rightalign
set statusline+=\ %Y                                             " Type of file in buffer
set statusline+=\ %(%3l:%-3c%)                                   " Line nr and column nr
set statusline+=\ %(%3p%%%)\                                     " Percentage in file

"" Floating Windows
" Normal item
hi Pmenu ctermbg=8 ctermfg=15
" Selected item
hi PmenuSel ctermbg=8 ctermfg=1

" Ruler
highlight ColorColumn ctermbg=8
