local o = vim.opt

o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.mouse = 'a'
o.termguicolors = true
o.linebreak = true
o.colorcolumn = '88'
o.cursorline = true
o.scrolloff = 3
o.signcolumn = 'yes'
o.foldlevelstart = 100
o.list = true
o.showbreak = '﬌ '
o.listchars = 'tab:» ,nbsp:·,trail:·'
o.shortmess:append('I')
o.confirm = true
o.undofile = true
o.backup = true
o.backupdir = vim.fn.stdpath 'data' .. '/backup//'
o.swapfile = true
o.spell = true

o.number = true
o.relativenumber = true


--set updatetime=300                                  " Shorter updatetime for shorter delay

--set cmdheight=2                                     " Always display the cmd

--set spelllang=en_gb,de_ch                           " Set languageto English and German
--set spellfile+=~/.config/nvim/spell/en.utf-9.add    " Add default spell file
--set spellfile+=ignore.utf-8.add                     " Add ignore file


--au FileType *  set formatoptions-=r formatoptions-=c formatoptions-=o " Disable auto comments

--" Save folds on save and restore automatically when open file
--"augroup remember_folds
--"  autocmd!
--"  autocmd BufWinLeave * mkview
--"  autocmd BufWinEnter * silent! loadview
--"augroup END

--" Enable / disable relative linenumbers depending on the mode
--:augroup numbertoggle
--:  autocmd!
--:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
--:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
--:augroup END
