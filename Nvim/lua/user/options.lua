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
o.foldenable=false -- Disable folds at startup
o.list = true
o.showbreak = '󱞩 '
o.listchars = 'tab:» ,nbsp:·,trail:·'
o.shortmess:append('I')
o.confirm = true
o.undofile = true
o.backup = true
o.backupdir = vim.fn.stdpath 'data' .. '/backup//'
o.swapfile = false
o.spell = true
o.updatetime = 300 -- To make the lsp highlight the word under the cursor faster

o.number = true
o.relativenumber = true

-- Vim uses magic to figure out if `.tex` file is of type LaTeX. Say it is always LaTex
vim.g.tex_flavor = 'latex'

vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]] --Sets in essence formatoptions-=cro, which disables continuing of comments after pressing enter


--set updatetime=300                                  " Shorter updatetime for shorter delay

--set cmdheight=2                                     " Always display the cmd

--set spelllang=en_gb,de_ch                           " Set languageto English and German
--set spellfile+=~/.config/nvim/spell/en.utf-9.add    " Add default spell file
--set spellfile+=ignore.utf-8.add                     " Add ignore file

-- vim.filetype.add({extension = {'S' = 'asm'}})
vim.cmd([[autocmd BufNewFile,BufRead *.S setfiletype asm]])

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
