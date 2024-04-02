local packer = require("lib.packer-init")

packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })

	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- 		-- "uga-rosa/cmp-dictionary",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"onsails/lspkind-nvim",
			-- 		"f3fora/cmp-spell",
		},
		config = function()
			require("user.plugins.cmp")
		end,
	})

	-- use({
	-- 	"uga-rosa/cmp-dictionary",
	-- 	config = function()
	-- 		require("user.plugins.cmp-dictionary")
	-- 	end,
	-- })

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

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		requires = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			--'b0o/schemastore.nvim',
			--'folke/lsp-colors.nvim',
			--'weilbith/nvim-code-action-menu',
		},
		config = function()
			require("user.plugins.lspconfig")
		end,
	})

	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("user.plugins.lsp_signature")
		end,
	})

	-- TODO: Null-ls is archived
	use({
		"jose-elias-alvarez/null-ls.nvim",
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
			require("user.plugins.comment")
		end,
	})

	-- LaTeX
	-- Requires: `xdotool`
	use({
		"lervag/vimtex",
		config = function()
			require("user.plugins.vimtex")
		end,
	})

	-- Display colors
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- Git
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

	-- Color Schema
	use({
		"RRethy/nvim-base16",
		config = function()
			require("user.base16")
		end,
	})

	-- Detect indentation to use in a certain file heuristically
	use({ "tpope/vim-sleuth" })

	-- Align Chars
	use({ "godlygeek/tabular" })
end)
