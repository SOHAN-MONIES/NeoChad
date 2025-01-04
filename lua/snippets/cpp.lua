local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet           -- Shortcut for snippet
local t = ls.text_node         -- Shortcut for text node
local i = ls.insert_node       -- Shortcut for insert node

ls.add_snippets("cpp", {
    s("sohan", {
        t({ "#include <bits/stdc++.h>", "", "using namespace std;", "", "int main() {", "\t" }),
        i(1, "// Code here"),
        t({ "", "\treturn 0;", "}" }),
    }),
})

