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
	keys = {
		-- {
		-- 	"Kh",
		-- 	function()
		-- 		vim.lsp.buf.hover({ border = "single" })
		-- 	end,
		-- 	"n",
		-- 	desc = "Hover",
		-- },
		-- { "Kh", function()vim.lsp.buf.hover({border = "rounded"}) end, "n", desc = "Hover" },
	},
	config = function()
		-- Setup Mason to automatically install LSP servers
		require("mason").setup({})
		require("mason-lspconfig").setup({ automatic_installation = true })

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Lua
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
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

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				local navic = require("nvim-navic")
				navic.attach(client, bufnr)
			end
		end

		-- Clangd C
		vim.lsp.config("clangd", {
			capabilities = capabilities,
			on_attach = on_attach,
			-- on_attach = function(client, bufnr)
			-- 	navic.attach(client, bufnr)
			-- end,
		})
		vim.lsp.enable("clangd")

		-- Latex
		-- FileType: { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" }
		vim.lsp.config("ltex_plus", {
			capabilities = capabilities,
		})
		vim.lsp.enable("ltex_plus")

		-- FileType: { "tex", "plaintex", "bib" }
		vim.lsp.config("texlab", {
			capabilities = capabilities,
		})
		vim.lsp.enable("texlab")

		-- Markdown
		vim.lsp.config("markdown_oxide", {
			-- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
			-- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
			capabilities = vim.tbl_deep_extend("force", capabilities, {
				workspace = {
					didChangeWatchedFiles = {
						dynamicRegistration = true,
					},
				},
			}),
			on_attach = on_attach, -- configure your on attach config
		})
		vim.lsp.enable("markdown_oxide")

		-- Bash
		-- FileType: { "bash", "sh" }
		vim.lsp.config("bashls", {
			capabilities = capabilities,
		})
		vim.lsp.enable("bashls")

		-- Python
		--- Fork of pyright
		vim.lsp.config("basedpyright", {
			capabilities = capabilities,
		})
		vim.lsp.enable("basedpyright")

		-- lspconfig.pyright.setup({
		-- 	capabilities = capabilities,
		-- })

		-- lspconfig.jedi_language_server.setup({
		-- 	capabilities = capabilities,
		-- })

		-- lspconfig.pylsp.setup({
		-- 	capabilities = capabilities,
		-- })

		-- Flags a shit ton of irrelevant stuff
		-- lspconfig.pylyzer.setup({
		-- 	capabilities = capabilities,
		-- })

		-- lspconfig.pyre.setup({
		-- 	capabilities = capabilities,
		-- })

		-- lspconfig.ruff.setup({
		-- 	capabilities = capabilities,
		-- })

		-- Rust
		vim.lsp.config("rust_analyzer", {
			capabilities = capabilities,
		})
		vim.lsp.enable("rust_analyzer")

		-- General Text
		-- lspconfig.harper.setup({
		-- 	capabilities = capabilities,
		-- })

		-- Keymaps
		-- TODO: attack keymaps to on_attack
		-- Goto
		-- Defined in fzf

		-- Show information
		vim.keymap.set("n", "Kh", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, { desc = "Hover" })
		vim.keymap.set("n", "KK", function()
			vim.lsp.buf.signature_help({ border = "rounded" }, { desc = "Signature" })
		end)

		-- Actions ("make")
		vim.keymap.set("n", "mn", vim.lsp.buf.rename)
		-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)  -- Use nvim-code-action-menu instead
		--- Format defined in ./conform.lua

		-- Diagnostics
		-- TODO: Move diagnostics to own file
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.INFO] = "",
					[vim.diagnostic.severity.HINT] = "",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					-- [vim.diagnostic.severity.WARN] = '',
					-- [vim.diagnostic.severity.INFO] = '',
					-- [vim.diagnostic.severity.HINT] = '',
				},
			},
			virtual_text = false,
			severity_sort = true,
			float = {
				border = "rounded",
				focusable = false,
				header = "",
				source = true,
				-- Display data provided by plugins, if provided, otherwise default
				format = function(diagnostic)
					if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
						return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
					end
					return diagnostic.message
				end,
			},
		})

		vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
		-- vim.keymap.set("n", "fn", vim.diagnostic.goto_prev)
		-- vim.keymap.set("n", "fp", vim.diagnostic.goto_next)
	end,
}
