require("luasnip.loaders.from_vscode").lazy_load() -- loads snippets from e.g. friendly snippets
require("luasnip.loaders.from_snipmate").lazy_load({paths = "./lua/user/plugins/luasnip_snippets"})
require("luasnip.loaders.from_lua").lazy_load({paths = "./lua/user/plugins/luasnip_snippets"})
