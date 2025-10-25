-- Show pending keybindings

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = { preset = "modern", delay = 1000, plugins = { spelling = { suggestions = 100 } } },
}
