local buf_keymap = require 'lib.utils'.buf_keymap

vim.diagnostic.config {
    virtual_text = false,
    severity_sort = true,
    float = {
        source = true,
        focusable = false,
        header = '',
        prefix = '',
        format = function(diagnostic)
            if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
                return string.format('%s: %s', diagnostic.user_data.lsp.code, diagnostic.message)
            end
            return diagnostic.message
        end,
    }
}

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

local function config(_config)
	return vim.tbl_deep_extend("force", {
        capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function(client, bufnr)
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

            buf_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
            buf_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
            buf_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
            buf_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
            buf_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
            buf_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
            buf_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
            buf_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
            buf_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

            buf_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
            vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]

            --buf_keymap(bufnr, 'n', '<leader>d','<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
            buf_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>')
            buf_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
            buf_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
            buf_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.diagnostic.setloclist()<CR>')
        end
--    -- Set autocommands conditional on server_capabilities
----  if client.resolved_capabilities.document_highlight then
----    vim.api.nvim_exec(
----      [[
----      augroup lsp_document_highlight
----        autocmd! * <buffer>
----        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
----        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
----      augroup END
----    ]],
----      false
----    )
----  end
--end
    }, _config or {})
end



local lspconfig = require('lspconfig')

lspconfig.pyright.setup(config())
lspconfig.hls.setup(config())
lspconfig.bashls.setup(config())
lspconfig.texlab.setup(config())
lspconfig.yamlls.setup(config())
lspconfig.ccls.setup(config())


-- TODO figure out why global vim is not found
--local runtime_path = vim.split(package.path, ';')
--table.insert(runtime_path, 'lua/?.lua')
--table.insert(runtime_path, 'lua/?/init.lua')
lspconfig.sumneko_lua.setup(config({
    --cmd = { '/home/jess/bin/lua-language-server', '-E', '/home/jess/bin/main.lua' },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                --path = runtime_path,
            },
        },
        diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { 'vim' },
        },
        workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
--            library = {
--					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
--					[vim.fn.stdpath('config') .. '/lua'] = true,
--				},
        },
        telemetry = {
            enable = false,
        },
    },
}))
