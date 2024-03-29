local packer = require("lib.packer-init")

packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })

	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("user.plugins.luasnip")
		end,
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind-nvim",
			"f3fora/cmp-spell",
		},
		config = function()
			require("user.plugins.cmp")
		end,
	})

	use({
		"rafamadriz/friendly-snippets",
		requires = {
			"hrsh7th/nvim-cmp",
		},
	})

	use({
		"uga-rosa/cmp-dictionary",
		requires = {
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("user.plugins.cmp-dictionary")
		end,
	})

	use({
		"neovim/nvim-lspconfig",
		requires = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			--'b0o/schemastore.nvim',
			--'folke/lsp-colors.nvim',
			--'weilbith/nvim-code-action-menu',
			{
				"ray-x/lsp_signature.nvim",
				config = function()
					require("user.plugins.lsp_signature")
				end,
			},
		},
		config = function()
			require("user.plugins.lspconfig")
		end,
	})

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

	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = function()
			require("user.plugins.telescope")
		end,
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"p00f/nvim-ts-rainbow",
		},
		config = function()
			require("user.plugins.treesitter")
		end,
	})

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Requires: `xdotool`
	use({
		"lervag/vimtex",
		config = function()
			require("user.plugins.vimtex")
		end,
	})

	use({ "tpope/vim-commentary" })

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("user.plugins.gitsigns")
		end,
	})

	use({
		"ThePrimeagen/harpoon",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			require("user.plugins.harpoon")
		end,
	})

	-- Smooth Scroll
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})

	use({
		"RRethy/nvim-base16",
		config = function()
			require("user.base16")
		end,
	})

	-- Detect indentation to use in a certain file heuristically
	use({
		"tpope/vim-sleuth",
	})

	use({
		"godlygeek/tabular",
	})
end)
