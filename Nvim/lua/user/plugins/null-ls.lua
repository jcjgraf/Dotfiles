local null_ls = require 'null-ls'

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local hover = null_ls.builtins.hover


local severities = { error = 1, warning = 2, suggestion = 4 }

null_ls.setup {
    -- FileType: { "markdown", "tex", "asciidoc" }
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
        -- FileType: { "org", "text", "markdown" } + { "tex" }
        hover.dictionary.with({ extra_filetypes = { 'tex' } }),
        -- FileType: { "markdown", "tex" } + { "tex" }
        diagnostics.proselint.with({ extra_filetypes = { 'txt' } }),
        -- FileType: { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx", "graphql", "handlebars" }
        formatting.prettier,
        -- FileType: { "bib" }
        formatting.bibclean,
        -- FileType: { "python" }
        formatting.black,
        -- FileType: { "lua", "luau" }
        formatting.stylua,
        -- FileType: { "arduino", "c", "cpp", "cs", "java" }
        -- formatting.astyle,
        -- FileType: { "python" }
        diagnostics.flake8,

    },
}
