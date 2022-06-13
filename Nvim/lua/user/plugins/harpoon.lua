local keymap = require 'lib.utils'.keymap

keymap('n', '<leader>a', '<cmd>lua require("harpoon.mark").add_file()<CR>')
keymap('n', '<leader>s', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>')

keymap('n', '<C-h>', '<cmd>lua require("harpoon.ui").nav_file(1)<CR>')
keymap('n', '<C-j>', '<cmd>lua require("harpoon.ui").nav_file(2)<CR>')
keymap('n', '<C-k>', '<cmd>lua require("harpoon.ui").nav_file(3)<CR>')
keymap('n', '<C-l>', '<cmd>lua require("harpoon.ui").nav_file(4)<CR>')
