local fzf = require("fzf-lua")

fzf.setup({})

vim.keymap.set("n", "<leader>f", fzf.files, { desc = "Fzf Files" })
vim.keymap.set("n", "<leader>g", fzf.live_grep, { desc = "Fzf Grep" })
vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, { desc = "Code Action" })
