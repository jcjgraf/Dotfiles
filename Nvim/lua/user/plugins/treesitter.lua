local treesitter_conf = require("nvim-treesitter.configs")

treesitter_conf.setup({
	ensure_installed = "all", -- { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" }, -- First 7 parser must always be installed
	auto_install = false, -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	ignore_install = { "hoon" }, -- Caused some trouble at some point in time
	highlight = {
		enable = true,
		disable = {}, -- name of parser and not filetypes
		additional_vim_regex_highlighting = true, -- 'true' may slowdown nvim
	},
	indent = {
		enable = false,
		disable = {},
	},
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
})

-- Let TS do the folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
