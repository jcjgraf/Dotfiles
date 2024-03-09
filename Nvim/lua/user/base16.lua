local base16 = require("base16-colorscheme")

base16.setup({
	base00 = "#2d2d2d", -- Default Background
	base01 = "#2c313c", -- Lighter Background (Used for status bars, line number and folding marks)
	base02 = "#3e4451", -- Selection Background
	base03 = "#6c7891", -- Comments, Invisibles, Line Highlighting
	base04 = "#565c64", -- Dark Foreground (Used for status bars)
	base05 = "#abb2bf", -- Default Foreground, Caret, Delimiters, Operators
	base06 = "#9a9bb3", -- Light Foreground (Not often used)
	base07 = "#c5c8e6", -- Light Background (Not often used)
	base08 = "#f2777a", -- Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
	base09 = "#d19a66", -- Integers, Boolean, Constants, XML Attributes, Markup Link Url
	base0A = "#ffcc66", -- Classes, Markup Bold, Search Text Background
	base0B = "#99cc99", -- Strings, Inherited Class, Markup Code, Diff Inserted
	base0C = "#6ccccc", -- Support, Regular Expressions, Escape Characters, Markup Quotes
	base0D = "#6699cc", -- Functions, Methods, Attribute IDs, Headings
	base0E = "#cc99cc", -- Keywords, Storage, Selector, Markup Italic, Diff Changed
	base0F = "#a06949", -- Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
})

local color = base16.colors

local set_Search = string.format(
	[[
	hi Search guibg=%s guifg=%s
]],
	color.base09,
	color.base00
)

vim.cmd(set_Search)
