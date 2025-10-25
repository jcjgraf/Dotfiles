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

		local lspconfig = require("lspconfig")

		-- Lua
		lspconfig.lua_ls.setup({
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

		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				local navic = require("nvim-navic")
				navic.attach(client, bufnr)
			end
		end

		-- Clangd C
		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- on_attach = function(client, bufnr)
			-- 	navic.attach(client, bufnr)
			-- end,
		})

		-- Latex
		-- FileType: { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" }
		lspconfig.ltex_plus.setup({
			capabilities = capabilities,
		})

		-- FileType: { "tex", "plaintex", "bib" }
		lspconfig.texlab.setup({
			capabilities = capabilities,
		})

		-- Bash
		-- FileType: { "bash", "sh" }
		lspconfig.bashls.setup({
			capabilities = capabilities,
		})

		-- Python
		lspconfig.basedpyright.setup({
			capabilities = capabilities,
		})

		lspconfig.jedi_language_server.setup({
			capabilities = capabilities,
		})

		lspconfig.pylsp.setup({
			capabilities = capabilities,
		})

		-- lspconfig.pylyzer.setup({
		-- 	capabilities = capabilities,
		-- })

		lspconfig.pyre.setup({
			capabilities = capabilities,
		})

		lspconfig.pyright.setup({
			capabilities = capabilities,
		})

		lspconfig.ruff.setup({
			capabilities = capabilities,
		})

		-- Rust
		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
		})

		-- General Text
		lspconfig.harper.setup({
			capabilities = capabilities,
		})

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
		vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
		vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
		vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
		vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

		vim.diagnostic.config({
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
