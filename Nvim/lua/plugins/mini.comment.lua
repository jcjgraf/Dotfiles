-- Commenting

return {
	"nvim-mini/mini.comment",
	version = false,
	keys = { { "ml", mode = { "n", "v" } } },
	config = function()
		require("mini.comment").setup({
			mappings = {
				comment = "ml",
				comment_line = "ml",
				comment_visual = "ml",
				textobject = "ml",
			},
		})
	end,
}
