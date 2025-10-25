-- Snippets

return {
	"L3MON4D3/LuaSnip",
	opts = {},
	lazy = true,
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load() -- For friendly-snippets
	end,
	-- version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	-- build = "make install_jsregexp"
}
