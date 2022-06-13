local cmp_dict = require('cmp_dictionary')

cmp_dict.setup({
    dic = {
        -- TODO set based on langq
        ['*'] = {'/home/jeanclaude/.local/share/dict/de_CH.dict'},
        --spelllang = {
        --    --en = '/home/jeanclaude/.local/share/dict/en_GB.dict'
        --    de = '/home/jeanclaude/.local/share/dict/de_CH.dict'
        --}
    }
})
