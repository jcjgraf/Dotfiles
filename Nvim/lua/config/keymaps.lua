vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable help
vim.keymap.set("", "<f1>", "<nop>")
vim.keymap.set("i", "<f1>", "<nop>")

-- Disable annoying command line thing
vim.keymap.set("n", "q:", "<nop>")

-- Move vertically by visual lines except a count is provided
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("v", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Paste replace visual selection without copying it
vim.keymap.set("v", "p", '"_dP')

vim.keymap.set("n", "<leader>k", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>Q", "<cmd>bufdo bdelete<cr>", { desc = "Close all buffers" })

-- Insert new line without going to insert mode
vim.keymap.set("n", "oo", "m`o<Esc>``", { desc = "Insert line below without entering insert mode" })
vim.keymap.set("n", "OO", "m`O<Esc>``", { desc = "Insert line above without entering insert mode" })

-- Fix last spelling mistake and return to cursor position
local function fix_last_spelling()
	vim.cmd("normal! [s")
	local bad = vim.fn.spellbadword()
	if bad[1] == "" then return end
	local suggestions = vim.fn.spellsuggest(bad[1], 1)
	if #suggestions == 0 then return end
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col + #bad[1], { suggestions[1] })
end

vim.keymap.set("n", "<C-s>", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	fix_last_spelling()
	vim.api.nvim_win_set_cursor(0, pos)
end, { desc = "Fix last spelling mistake" })

vim.keymap.set("i", "<C-s>", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd("stopinsert")
	fix_last_spelling()
	vim.api.nvim_win_set_cursor(0, pos)
	vim.cmd("startinsert")
end, { desc = "Fix last spelling mistake" })

-- Reselect visual selection after indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- LSP
vim.keymap.set("n", "Kh", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover" })
vim.keymap.set("n", "KK", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, { desc = "Signature help" })
vim.keymap.set("n", "mn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
