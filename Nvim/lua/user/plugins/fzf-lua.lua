local fzf = require("fzf-lua")

fzf.setup({
	-- winopts = { col = 0, row = 0, width = 1, height = 1 },
	winopts = {fullscreen = true},
	-- "hide", -- Keep search running in the background -> easier to resume
})

vim.keymap.set("n", "<leader>f", fzf.files, { desc = "FZF Files" })
vim.keymap.set("n", "<leader>g", fzf.live_grep, { desc = "FZF Grep" })
vim.keymap.set("n", "<leader>G", fzf.lgrep_curbuf, { desc = "FZF Grep Current Buffer" })
vim.keymap.set("n", "<leader>b", fzf.buffers, { desc = "FZF Buffers" })
vim.keymap.set("n", "<leader>j", fzf.jumps, { desc = "FZF Jump History" })
vim.keymap.set("n", "<leader>r", fzf.resume, { desc = "FZF Resume" })

vim.keymap.set("n", "<leader>ca", fzf.lsp_code_actions, { desc = "Code Action" })

vim.keymap.set("n", "gD", fzf.lsp_declarations, {})
vim.keymap.set("n", "gd", fzf.lsp_definitions, {})
vim.keymap.set("n", "gt", fzf.lsp_typedefs, {})
vim.keymap.set("n", "gr", fzf.lsp_references, {})
vim.keymap.set("n", "gi", fzf.lsp_implementations, {})
vim.keymap.set("n", "gs", fzf.lsp_document_symbols, {})
vim.keymap.set("n", "gS", fzf.lsp_workspace_symbols, {})

vim.keymap.set("n", "gci", fzf.lsp_incoming_calls, {})
vim.keymap.set("n", "gco", fzf.lsp_outgoing_calls, {})

vim.keymap.set("n", "gf", fzf.lsp_finder, {})

vim.keymap.set("n", "Kd", fzf.diagnostics_document, {})
vim.keymap.set("n", "KD", fzf.diagnostics_workspace, {})
