-- Setup LSP capabilities and dependencies
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
})

local lspconfig = require("lspconfig")
local luasnip = require("luasnip")
local cmp = require("cmp")

-- Define the list of language servers
local servers = {
    "rust_analyzer", "clangd", "ts_ls", "eslint", "cssls", "lua_ls", "emmet_language_server", "tailwindcss"
}

-- Setup LSP servers
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
    })
end

-- Specific configuration for Lua LSP
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
        },
    },
})

-- ESLint LSP setup with auto-fix on file save
lspconfig.eslint.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
})

-- Setup LuaSnip
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup for auto-completion
cmp.setup({
    completion = {
        autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
        },
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),  -- Scroll up
        ["<C-d>"] = cmp.mapping.scroll_docs(4),   -- Scroll down
        ["<C-Space>"] = cmp.mapping.complete(),   -- Trigger completion
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
})

-- Diagnostics navigation mappings
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- LSP key mappings on LspAttach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        local opts = { buffer = ev.buf }

        -- Key mappings for LSP actions
        local lsp_buf_map = {
            { "n", "gD", vim.lsp.buf.declaration },
            { "n", "gd", vim.lsp.buf.definition },
            { "n", "K", vim.lsp.buf.hover },
            { "n", "gi", vim.lsp.buf.implementation },
            { "n", "<C-k>", vim.lsp.buf.signature_help },
            { "n", "<space>wa", vim.lsp.buf.add_workspace_folder },
            { "n", "<space>wr", vim.lsp.buf.remove_workspace_folder },
            { "n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end },
            { "n", "<space>D", vim.lsp.buf.type_definition },
            { "n", "<space>rn", vim.lsp.buf.rename },
            { { "n", "v" }, "<space>ca", vim.lsp.buf.code_action },
            { "n", "gr", vim.lsp.buf.references },
            { "n", "<space>f", function() vim.lsp.buf.format { async = true } end },
        }

        -- Apply the key mappings
        for _, map in ipairs(lsp_buf_map) do
            vim.keymap.set(map[1], map[2], map[3], opts)
        end
    end,
})

-- Configure diagnostics
vim.diagnostic.config({
    update_in_insert = true,
})
