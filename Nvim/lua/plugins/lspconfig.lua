-- Language Server Protocol

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
	},
	event = { "BufReadPost", "BufWritePost", "BufNewFile" },
	config = function()
		-- Setup Mason to automatically install LSP servers
		require("mason").setup({})
		require("mason-lspconfig").setup({ automatic_installation = true })

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				local navic = require("nvim-navic")
				navic.attach(client, bufnr)
			end
		end

		-- Global config for all servers
		vim.lsp.config("*", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						checkThirdParty = false,
						library = {
							"${3rd}/luv/library",
							unpack(vim.api.nvim_get_runtime_file("", true)),
						},
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- Clangd C
		vim.lsp.config("clangd", {})
		vim.lsp.enable("clangd")

		-- Latex
		-- FileType: { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" }
		vim.lsp.config("ltex_plus", {})
		vim.lsp.enable("ltex_plus")

		-- FileType: { "tex", "plaintex", "bib" }
		vim.lsp.config("texlab", {})
		vim.lsp.enable("texlab")

		-- Markdown
		-- vim.lsp.config("markdown_oxide", {
		-- 	-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
		-- 	-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
		-- 	capabilities = vim.tbl_deep_extend("force", capabilities, {
		-- 		workspace = {
		-- 			didChangeWatchedFiles = {
		-- 				dynamicRegistration = true,
		-- 			},
		-- 		},
		-- 	}),
		-- })
		-- vim.lsp.enable("markdown_oxide")

		-- Bash
		-- FileType: { "bash", "sh" }
		vim.lsp.config("bashls", {})
		vim.lsp.enable("bashls")

		-- Python
		-- Fork of pyright
		vim.lsp.config("basedpyright", {})
		vim.lsp.enable("basedpyright")

		-- lspconfig.pyright.setup({})

		-- lspconfig.jedi_language_server.setup({})

		-- lspconfig.pylsp.setup({})

		-- Flags a shit ton of irrelevant stuff
		-- lspconfig.pylyzer.setup({})

		-- lspconfig.pyre.setup({})

		-- lspconfig.ruff.setup({})

		-- Rust
		vim.lsp.config("rust_analyzer", {})
		vim.lsp.enable("rust_analyzer")

		-- General Text
		-- lspconfig.harper.setup({})
	end,
}
