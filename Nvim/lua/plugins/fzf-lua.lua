-- Search and find

return {
	"ibhagwan/fzf-lua",
	dependencies = {
		"neovim/nvim-lspconfig", -- For LSP Support
		"nvim-tree/nvim-web-devicons", -- (Optional) For Icons
	},
	keys = {
		{ "<leader>f", "<cmd>FzfLua files -L<cr>", desc = "FZF Files" },
		{ "<leader>g", "<cmd>FzfLua live_grep<cr>", desc = "FZF Grep" },
		{ "<leader>G", "<cmd>FzfLua live_grep --glob<cr>", desc = "FZF Grep" },
		-- { "<leader>G", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "FZF Grep Current Buffer" },
		{ "<leader>b", "<cmd>FzfLua buffers<cr>", desc = "FZF Buffers" },
		{ "<leader>m", "<cmd>FzfLua marks<cr>", desc = "FZF Marks" },
		{ "<leader>j", "<cmd>FzfLua jumps<cr>", desc = "FZF Jump History" },
		{ "<leader>r", "<cmd>FzfLua resume<cr>", desc = "FZF Resume" },

		{ "<leader>ca", "<cmd>FzfLua lsp_code_actions<cr>", mode = "n", desc = "Code Actions" },

		{ "gD", "<cmd>FzfLua lsp_declarations<cr>", mode = "n", desc = "Go Declaration" },
		{ "gd", "<cmd>FzfLua lsp_definitions<cr>", mode = "n", desc = "Go Definition" },
		{ "gt", "<cmd>FzfLua lsp_typedefs<cr>", mode = "n", desc = "Go Type Definition" },
		{ "gr", "<cmd>FzfLua lsp_references<cr>", mode = "n", desc = "References" },
		{ "gi", "<cmd>FzfLua lsp_implementations<cr>", mode = "n", desc = "Implementations" },
		{ "gs", "<cmd>FzfLua lsp_document_symbols<cr>", mode = "n", desc = "Document Symbols" },
		{ "gS", "<cmd>FzfLua lsp_workspace_symbols<cr>", mode = "n", desc = "Workspace Symbols" },

		{ "gci", "<cmd>FzfLua lsp_incoming_calls<cr>", mode = "n", desc = "Incoming calls" },
		{ "gco", "<cmd>FzfLua lsp_outgoing_calls<cr>", mode = "n", desc = "Outgoing calls" },

		{ "gf", "<cmd>FzfLua lsp_finder<cr>", mode = "n", desc = "LSP Finder" },

		{ "Kd", "<cmd>FzfLua diagnostics_document<cr>", mode = "n", desc = "Diagnose Document" },
		{ "KD", "<cmd>FzfLua diagnostics_workspace<cr>", mode = "n", desc = "Diagnose Workspace" },
	},
	opts = {
		winopts = { fullscreen = true },
		-- "hide",
		defaults = {
			hidden = true, -- Show hidden files (true is default)
			follow = true, -- Follow symlinks (false is default)
			-- no_ignore = true, -- Respect .gitignore (false default)
		},
	},
}
