local o = vim.opt

o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.mouse = "a"
o.termguicolors = true
o.linebreak = true -- Wrap long lines at word boundaries, not mid-word
o.colorcolumn = "88"
o.cursorline = true
o.scrolloff = 3 -- Keep 3 lines of context visible above/below the cursor
o.signcolumn = "yes"
o.foldenable = false -- Disable folds at startup
o.list = true -- Show invisible characters defined in listchars
o.showbreak = "󱞩 "
o.listchars = "tab:» ,nbsp:·,trail:·"
o.shortmess:append("I") -- Suppress the intro/splash screen
o.confirm = true -- Ask for confirmation instead of failing when closing unsaved buffers
o.undofile = true -- Persist undo history across sessions
o.backup = true -- Keep a backup file when overwriting
o.backupdir = vim.fn.stdpath("data") .. "/backup//"
vim.fn.mkdir(vim.fn.stdpath("data") .. "/backup", "p")
o.swapfile = false -- Swap files are redundant with backup + undofile
o.spell = true
o.spelllang = "en"
o.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
o.updatetime = 300 -- To make the lsp highlight the word under the cursor faster
-- Case insensitive search if all lower-case, else sensitive
o.ignorecase = true
o.smartcase = true

-- Show relative file numbers in normal mode, switch to absolute in insert
o.number = true
o.relativenumber = true

local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	group = numbertoggle,
	callback = function()
		vim.wo.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	group = numbertoggle,
	callback = function()
		vim.wo.relativenumber = false
	end,
})

-- Vim uses magic to figure out if `.tex` file is of type LaTeX. Say it is always LaTex
vim.g.tex_flavor = "latex"

-- Disable auto-insertion of comment leaders on Enter/o/O (filetypes reset formatoptions, so must apply per buffer)
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Highlight non-ascii characters (matchadd works alongside treesitter, syntax match does not)
-- Color defined in base16.lua where the palette is available
local highlight_nonascii = vim.api.nvim_create_augroup("HighlightNonASCII", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
	group = highlight_nonascii,
	callback = function()
		for _, m in ipairs(vim.fn.getmatches()) do
			if m.group == "NonASCII" then
				return
			end
		end
		vim.fn.matchadd("NonASCII", [=[[^\x00-\x7f]]=])
	end,
})

vim.filetype.add({ extension = { S = "asm" } }) -- .S files are GAS assembly

-- Diagnostics
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			-- [vim.diagnostic.severity.WARN] = '',
			-- [vim.diagnostic.severity.INFO] = '',
			-- [vim.diagnostic.severity.HINT] = '',
		},
	},
	virtual_text = false,
	severity_sort = true,
	float = {
		border = "rounded",
		focusable = false,
		header = "",
		source = true,
		-- Display data provided by plugins, if provided, otherwise default
		format = function(diagnostic)
			if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
				return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
			end
			return diagnostic.message
		end,
	},
})
