-- Import which-key plugin
local wk = require("which-key")

-- Define key mappings
local mappings = {
    -- Basic editor commands
    q = { ":q!<cr>", "Quit" },               -- Force quit
    w = { ":w!<cr>", "Save" },               -- Force save
    x = { ":bdelete<cr>", "Close" },         -- Close buffer
    Q = { ":wq!<cr>", "Save & Quit" },       -- Save and quit
    
    -- Navigation and file management
    e = { ":NvimTreeToggle<cr>", "File Explorer" }, -- Toggle NvimTree
    s = { ":Telescope find_files<cr>", "Search Files" }, -- Search files
    g = { ":Telescope live_grep<cr>", "Live Grep" },    -- Live grep

    -- Miscellaneous
    d = { ":Trouble<cr>", "Diagnostics" },  -- Open diagnostics
    r = { ":RunCode<cr>", "Run Code" },     -- Run code using RunCode plugin
    t = { ":ToggleTerm<cr>", "Terminal" },  -- Toggle terminal

    -- Window management
    S = { ":vsplit<cr>", "Split Vertically" },  -- Split window vertically
}

-- Configure which-key with the defined mappings
local opts = { prefix = '<leader>' }  -- Set leader key as prefix
wk.register(mappings, opts)  -- Register the mappings
