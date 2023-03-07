require('neoscroll').setup({
    hide_cursor = true,
})

require('neoscroll.config').set_mappings({
    ['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '200' } },
    ['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '200' } },
    ['<C-b>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '350' } },
    ['<C-f>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '350' } },
    ['<C-y>'] = { 'scroll', { '-0.10', 'false', '100' } },
    ['<C-e>'] = { 'scroll', { '0.10', 'false', '100 '} },
    ['zt']    = { 'zt', { '150' } },
    ['zz']    = { 'zz', { '150' } },
    ['zb']    = { 'zb', { '150' } },
})
