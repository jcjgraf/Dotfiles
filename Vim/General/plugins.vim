" install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/plugged')

" Colorize color values
Plug 'chrisbra/Colorizer'

" Pandoc base and syntax
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Inkscape integration
Plug 'silverbulletmdc/vim-inkscape-insert'

" i3 syntax
Plug 'mboughaba/i3config.vim'

" Latex Support
Plug 'lervag/vimtex', {'for': 'tex'}

" Snippets
Plug 'sirver/ultisnips', {'for': 'tex'}

" Fuzzy File manager
Plug 'ctrlpvim/ctrlp.vim'

" Align text
Plug 'godlygeek/tabular'

" Autocomplete and loockup
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Python autocompletion
"Plug 'davidhalter/jedi-vim', {'for': 'python'}

" Syntax check
Plug 'vim-syntastic/syntastic'

" Python folding
Plug 'tmhedberg/SimpylFold', {'for': 'python'}

" Git diff in sign column
Plug 'mhinz/vim-signify'

" Save files wit sudo
Plug 'github.com/lambdalisue/suda.vim'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
