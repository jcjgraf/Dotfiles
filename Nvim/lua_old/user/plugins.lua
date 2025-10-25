local packer = require("lib.packer-init")

packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })

	-- Snippets
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("user.plugins.luasnip")
		end,
	})

	use({
		"rafamadriz/friendly-snippets",
	})

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("user.plugins.lsp_signature")
		end,
	})

	use({
		"nvimtools/none-ls.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("user.plugins.null-ls")
		end,
	})
	-- TODO: deprecated
	use({
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	})

	use({
		"kosayoda/nvim-lightbulb",
		requires = "antoinemadec/FixCursorHold.nvim",
		config = function()
			require("user.plugins.lightbulb")
		end,
	})

	-- Display colors
	-- use({
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	config = function()
	-- 		require("colorizer").setup()
	-- 	end,
	-- })

	-- Since norcalli's colorizer does not support ANSI colors
	use({
		"chrisbra/Colorizer",
	})

	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			require("user.plugins.harpoon")
		end,
	})

	-- Detect indentation to use in a certain file heuristically
	use({ "tpope/vim-sleuth" })

	-- Align Chars
	use({ "godlygeek/tabular" })
end)
