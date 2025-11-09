return {
	{
		"zhisme/copy_with_context.nvim",
		config = function()
			require("copy_with_context").setup({
				-- Customize mappings
				mappings = {
					relative = "<leader>cy",
					absolute = "<leader>cY",
				},
				-- whether to trim lines or not
				trim_lines = false,
				context_format = "%s:%s", -- Default format for context: "# Source file: filepath:line"
			})
		end,
	},
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" },
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			settings = {
				save_on_toggle = true,
				-- sync_on_ui_close = true,
			},
		},
		init = function()
			local harpoon = require("harpoon")

			vim.keymap.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Harpoon add" })
			vim.keymap.set("n", "<leader>s", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end, { desc = "Harpoon List" })

			vim.keymap.set("n", "<leader>1", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon 1" })
			vim.keymap.set("n", "<leader>2", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon 2" })
			vim.keymap.set("n", "<leader>3", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon 3" })
			vim.keymap.set("n", "<leader>4", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon 4" })
			vim.keymap.set("n", "<leader>5", function()
				harpoon:list():select(5)
			end, { desc = "Harpoon 5" })
			vim.keymap.set("n", "<leader>6", function()
				harpoon:list():select(6)
			end, { desc = "Harpoon 6" })
			vim.keymap.set("n", "<leader>7", function()
				harpoon:list():select(7)
			end, { desc = "Harpoon 7" })
			vim.keymap.set("n", "<leader>8", function()
				harpoon:list():select(8)
			end, { desc = "Harpoon 8" })
			vim.keymap.set("n", "<leader>9", function()
				harpoon:list():select(9)
			end, { desc = "Harpoon 9" })
			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function()
				harpoon:list():prev()
			end)
			vim.keymap.set("n", "<C-S-N>", function()
				harpoon:list():next()
			end)
		end,
	},
}
