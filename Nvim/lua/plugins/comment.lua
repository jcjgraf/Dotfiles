-- Commenting

return {
	"numToStr/Comment.nvim",
	keys = { { "ml", mode = { "n", "v" } }, { "mb", mode = { "n", "v" } } },
	opts = {
		---LHS of toggle mappings in NORMAL mode
		toggler = {
			---Line-comment toggle keymap
			line = "ml",
			---Block-comment toggle keymap
			block = "mb",
		},
		---LHS of operator-pending mappings in NORMAL and VISUAL mode
		opleader = {
			---Line-comment keymap
			line = "ml",
			---Block-comment keymap
			block = "mb",
		},
		extra = {},
		mappings = {
			---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
			basic = true,
			---Extra mapping; `gco`, `gcO`, `gcA`
			extra = false,
		},
	},
}

--local ft = require("Comment.ft")
--
--ft.set("asm", "#%s")
--
