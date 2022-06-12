local telescope = require 'telescope'
local actions = require 'telescope.actions'
local keymap = require 'lib.utils'.keymap

telescope.setup {
    defaults = {
        mappings = {
            i = {
                ['<esc>'] = actions.close,
            }
        },
        file_ignore_patterns = { '.git/' },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
        buffers = {
            previewer = false,
            layout_config = {
                width = 80,
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
            -- the default case_mode is 'smart_case'
        },
    }
}

telescope.load_extension 'fzf'


keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
keymap('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]])
keymap('n', '<leader>r', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
