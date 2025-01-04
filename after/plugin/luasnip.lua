require("luasnip.loaders.from_vscode").lazy_load({
  paths = "~/.config/nvim/lua/snippets/",
})
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets/" })

