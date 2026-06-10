-- File browser/tree

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		keys = {
			{ "<leader>ee", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
			{ "<leader>er", "<cmd>Neotree reveal<cr>", desc = "Show current file in Neotree" },
		},
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					show_hidden_count = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					-- 				hide_by_name = {
					-- 					-- '.git',
					-- 					-- '.DS_Store',
					-- 					-- 'thumbs.db',
				},
				-- 				never_show = {},
			},
		},
	},
}
