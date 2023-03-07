local keymap = require 'lib/utils'.keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable help
keymap('', '<f1>', '<nop>')
keymap('i', '<f1>', '<nop>')

-- Disable annoying command line thing
keymap('n', 'q:', '<nop>')

-- Move vertically by visual lines except a count is provided
keymap('n', 'k', 'v:count == 0 ? \'gk\' : \'k\'', { expr = true })
keymap('n', 'j', 'v:count == 0 ? \'gj\' : \'j\'', { expr = true })
keymap('v', 'k', 'v:count == 0 ? \'gk\' : \'k\'', { expr = true })
keymap('v', 'j', 'v:count == 0 ? \'gj\' : \'j\'', { expr = true })

-- Paste replace visual selection without copying it
keymap('v', 'p', '"_dP')

keymap('n', '<leader>e', ':Lex 30<cr>')

keymap('n', '<leader>k', ':nohlsearch<CR>')
keymap('n', '<leader>Q', ':bufdo bdelete<CR>')

-- Insert new line without going to insert mode
keymap('n', 'oo', 'm`o<Esc>``')
keymap('n', 'OO', 'm`O<Esc>``')

-- Corrects last spelling
keymap('i', '<C-l>', '<c-g>u<Esc>[s1z=`]a<c-g>u') -- TODO make work in normal mode

-- Allow gf to open non-existing file
keymap('', 'gf', ':edit <cfile><CR>')

-- Reselect visual selection after indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

keymap('n', '<leader>c', ':ColorizerToggle<CR>')

--buf_keymap(bufnr, 'n', '<leader>d','<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
keymap('n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>')

keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')


--" Open and close folds
--"nnoremap <leader>f zA

-- Do not move cursor after yank
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
--keymap("v", "y", '<expr>y "my\"" . v:register . "y`y"'

--" Insert new line without enterint insert
--nnoremap oo o<Esc>k
--nnoremap OO O<Esc>j


--" Move to errors
--nnoremap <leader>e :lnext<CR>
--nnoremap <leader>E :lprevious<CR>

--" Search for selected text, forwards or backwards.
--vnoremap <silent> * :<C-U>
--  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
--  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

--"" Remove Trailing Spaces by calling `TrimWhitespaces` or using a shortcut
--fun! TrimWhitespace()
--    let l:save = winsaveview()
--    keeppatterns %s/\s\+$//e
--    call winrestview(l:save)
--endfun
--command! TrimWhitespace call TrimWhitespace()
--:noremap <Leader>w :call TrimWhitespace()<CR>

--"" Show buffers and allow easy selection
--nnoremap <Leader>b :ls<Cr>:b<Space>

--"" Markdown
--" pandoc , markdown
--command! -nargs=* RunSilent
--      \ | execute ':silent !'.'<args>'
--      \ | execute ':redraw!'
--nmap <Leader>pc :RunSilent pandoc -o /tmp/vim-pandoc-out.pdf %<CR>
--nmap <Leader>pp :RunSilent xdg-open /tmp/vim-pandoc-out.pdf<CR>
