require("toggleterm").setup {
  -- General Settings
  size = 13,                     -- Terminal size (rows for horizontal layout)
  open_mapping = [[<c-'>]],       -- Keybinding to open terminal

  -- Visual Settings
  shade_filetypes = {},          -- No filetypes to shade (empty table means no filetype-specific shading)
  shade_terminals = true,        -- Apply shading to terminals
  shading_factor = '15',         -- Intensity of shading (value between 0-100)

  -- Behavior Settings
  start_in_insert = true,        -- Start in insert mode when terminal is opened
  persist_size = true,           -- Retain the terminal size across sessions

  -- Layout Settings
  direction = 'horizontal',      -- Terminal layout direction ('horizontal' or 'vertical')

  -- Window Bar (Winbar) Settings
  winbar = {
    enabled = false,              -- Disable winbar for the terminal
    name_formatter = function(term) 
      return term.name             -- Use terminal's name as winbar title (if enabled)
    end
  },
}
