-- TODO make sure everything is disable to prevent interference with lsp, treesitter etc.
vim.cmd([[let g:vimtex_compiler_progname = 'nvr']])
vim.cmd([[let g:vimtex_view_method='zathura']])
vim.cmd([[let g:vimtex_compiler_latexmk = {
        \ 'build_dir' : 'build',
        \}
]])
vim.cmd([[let g:vimtex_mappings_enabled=0]])
vim.cmd([[let g:vimtex_syntax_enabled=0]])

vim.keymap.set("n", "<leader>ll", ":VimtexCompile<CR>")
vim.keymap.set("n", "<leader>lc", ":VimtexClean<CR>")
vim.keymap.set("n", "<leader>lv", ":VimtexView<CR>")
