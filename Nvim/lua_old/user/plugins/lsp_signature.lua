local lsp_signature = require("lsp_signature")

-- TODO: Not greatest mapping since they differ for "n" and "i"
vim.keymap.set({ "n" }, "Ks", function()
	lsp_signature.toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

vim.keymap.set({ "i" }, "<C-K>", function()
	lsp_signature.toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle signature" })

lsp_signature.setup({})
