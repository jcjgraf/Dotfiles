-- Vimtex

return {
	-- Requires: `xdotool`
	"lervag/vimtex",
	lazy = false, -- lazy loading breaks vimtex
	init = function()
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_compiler_latexmk = {
			aux_dir = "build",
			out_dir = "build",
		}
        -- Do not use any default mappings
        vim.g.vimtex_mappings_enabled = false
        vim.g.tex_flavor = "latex"
	end,
}

