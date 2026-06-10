-- Syntax Highlighting

return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"asm",
				"bash",
				"c",
				"cmake",
				"comment",
				"csv",
				"diff",
				"disassembly",
				"dockerfile",
				"elixir",
				"git_config",
				"git_rebase",
				"gitattributes",
				"gitcommit",
				"gitignore",
				"heex",
				"html",
				"ini",
				"javascript",
				"json",
				"jsonc",
				"latex",
				"lua",
				"luadoc",
				"make",
				"markdown",
				"objdump",
				"passwd",
				"python",
				"query",
				"regex",
				"rust",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})

		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end,
}
