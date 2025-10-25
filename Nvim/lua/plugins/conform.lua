-- Formatting

return {
	"stevearc/conform.nvim",
	dependencies = { "williamboman/mason.nvim" },
	keys = {
		{
			"mf",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 3000,
				})
			end,
			mode={ "n", "v" },
			desc = "Format file or range (in visual mode)",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
			-- You can customize some of the format options for the filetype (:help conform.format)
			rust = { "rustfmt", lsp_format = "fallback" },
			-- Conform will run the first available formatter
			javascript = { "prettierd", "prettier", stop_after_first = true },
            sh = { "beautysh" },
            bib = { "bibtex-tidy" },
            c = { "clang-format" },
            gitcommit = { "commitmsgfmt" },
		},
	},
}
