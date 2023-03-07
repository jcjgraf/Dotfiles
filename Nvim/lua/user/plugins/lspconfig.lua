vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ async = true })
end, {})

vim.keymap.set("n", "<leader>ca", ":CodeActionMenu<CR>")
vim.keymap.set("v", "<leader>ca", ":CodeActionMenu<CR>")

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")

-- Enable border for floats
local _border = "single"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = _border,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = _border,
})

require("lspconfig.ui.windows").default_options = {
	border = _border,
}

vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		border = _border,
		source = true,
		focusable = false,
		header = "",
		prefix = "",
		format = function(diagnostic)
			if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
				return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
			end
			return diagnostic.message
		end,
	},
})

-- vim.lsp.set_log_level("debug")

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- local bufopts = { buffer=bufnr }

	-- Goto
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gdd", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

	-- Show information
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "KK", vim.lsp.buf.signature_help, bufopts)

	-- Actions ("make")
	vim.keymap.set("n", "mn", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "mf", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	-- Workspace stuff
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	-- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")

-- FileType: { "python" }
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "python" }
lspconfig.jedi_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "haskell", "lhaskell" }
lspconfig.hls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "sh" }
lspconfig.bashls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "yaml", "yaml.docker-compose" }
lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "c", "cpp", "objc", "objcpp" }
-- local clangd_capabilities = capabilities
-- clangd_capabilities.offsetEncoding = { "utf-16" }

-- lspconfig.ccls.setup({
-- 	on_attach = on_attach,
-- 	capabilities = clangd_capabilities,
-- })

-- FileType: { "c", "cpp", "objc", "objcpp", "cuda", "proto" }
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc" }
lspconfig.ltex.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "tex", "plaintex", "bib" }
lspconfig.texlab.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "go", "gomod", "gowork", "gotmpl" }
lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "rust" }
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- FileType: { "lua" }
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			-- workspace = {
			-- 	-- Make the server aware of Neovim runtime files
			-- 	library = vim.api.nvim_get_runtime_file("", true),
			-- },
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
