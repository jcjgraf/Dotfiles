local null_ls = require 'null-ls'

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover


local severities = { error = 1, warning = 2, suggestion = 4 }

null_ls.setup {
    sources = {
        diagnostics.vale.with({
            extra_filetypes = { 'txt' },
            -- TODO make xdg dir work
            --extra_args = { '--config=' .. vim.fs.normalize('$XDG_CONFIG_HOME/vale/vale.ini') },
            extra_args = { '--config=/home/jeanclaude/.config/vale/vale.ini' },
            -- From source https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/lua/null-ls/builtins/diagnostics/vale.lua
            on_output = function(params)
                local output = params.output["stdin." .. vim.fn.fnamemodify(params.bufname, ":e")]
                    or params.output[params.bufname]
                    or {}

                local diag = {}
                for _, diagnostic in ipairs(output) do
                    table.insert(diag, {
                        row = diagnostic.Line,
                        col = diagnostic.Span[1],
                        end_col = diagnostic.Span[2] + 1,
                        code = diagnostic.Check,
                        message = diagnostic.Message .. ' (' .. diagnostic.Check .. ')',
                        severity = severities[diagnostic.Severity],
                    })
                end
            return diag
        end,
        }),
        hover.dictionary.with({ extra_filetypes = { 'tex' } }),
        diagnostics.proselint.with({ extra_filetypes = { 'txt' } }),
        formatting.black,
        formatting.stylua,
        diagnostics.flake8,
    },
}
