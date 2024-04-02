local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
		file_ignore_patterns = { ".git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		buffers = {
			previewer = false,
			layout_config = {
				width = 80,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or 'ignore_case' or 'respect_case'
			-- the default case_mode is 'smart_case'
		},
	},
})

telescope.load_extension("fzf")
local builtin = require("telescope.builtin")

-- vim.keymap.set("n", "<C-f>", builtin.find_files)
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set("n", "<leader>fF", function() builtin.find_files({ no_ignore = true }) end, {})

-- Files opened via find_files cannot be folded (https://github.com/nvim-telescope/telescope.nvim/issues/699). Workaround...
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*" },
	command = "normal zx zR",
})
