vim.keymap.set("n", "<leader>ca", ":CodeActionMenu<CR>")
vim.keymap.set("v", "<leader>ca", ":CodeActionMenu<CR>")

-- Enable border for floats
local _border = "single"

require("lspconfig.ui.windows").default_options = {
	border = _border,
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	-- local bufopts = { buffer=bufnr }

	-- From https://smarttech101.com/nvim-lsp-configure-language-servers-shortcuts-highlights/#highlight_symbol_under_the_cursor_using_nvim_lsp
	if client.server_capabilities.documentHighlightProvider then
		local color = require("base16-colorscheme").colors
		local c = color.base02

		-- TODO: Somehow guibg works but ctermbg not
		local set_LspReferenceRead = string.format(
			[[
			hi! LspReferenceRead gui=none guibg=%s
			]],
			c
		)

		local set_LspReferenceWrite = string.format(
			[[
			hi! LspReferenceWrite gui=none guibg=%s
			]],
			c
		)
		local set_LspReferenceText = string.format(
			[[
			hi! LspReferenceText gui=none guibg=%s
			]],
			c
		)

		vim.cmd(set_LspReferenceRead)
		vim.cmd(set_LspReferenceText)
		vim.cmd(set_LspReferenceWrite)

		-- vim.api.nvim_create_augroup("lsp_document_highlight", {})
		-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
		-- 	group = "lsp_document_highlight",
		-- 	buffer = 0,
		-- 	callback = vim.lsp.buf.document_highlight,
		-- })
		-- vim.api.nvim_create_autocmd("CursorMoved", {
		-- 	group = "lsp_document_highlight",
		-- 	buffer = 0,
		-- 	callback = vim.lsp.buf.clear_references,
		-- })
	end

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
-- lspconfig.jedi_language_server.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- })

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
	cmd = {
		"clangd",
		"--header-insertion-decorators=false", -- Prevent indentation (see https://github.com/hrsh7th/nvim-cmp/issues/999)
	},
})

lspconfig.marksman.setup({})

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

-- FileType: { "asm", "vmasm" }
lspconfig.asm_lsp.setup({})
