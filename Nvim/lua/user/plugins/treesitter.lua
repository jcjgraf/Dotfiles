local treesitter_conf = require 'nvim-treesitter.configs'

treesitter_conf.setup {
    ensure_installed = 'all',
    ignore_install = {},
    highlight = {
        enable = true,
        disable = {}, -- name of parser and not filetypes
        additional_vim_regex_highlighting = true, -- 'true' may slowdown nvim
    },
    indent = {
        enable = true,
        disable = {},
    },
    context_commentstring = {
        enable = true,
    },
}

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
