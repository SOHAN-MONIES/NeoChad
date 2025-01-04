local db = require('dashboard')

-- Dashboard Setup
db.setup({
  theme = 'hyper',  -- Set the theme for the dashboard

  config = {
    -- Week Header Configuration
    week_header = {
      enable = false,  -- Disable the week header section
    },

    -- Shortcut Configuration
    shortcut = {
      -- Update shortcut
      { 
        desc = '󰊳 Update',          -- Description of the action
        group = '@property',         -- Group for highlighting
        action = 'Lazy update',      -- Command to execute on shortcut press
        key = 'u',                   -- Keybinding for the shortcut
      },
      -- Files shortcut
      {
        icon = ' ',                 -- Icon for the shortcut
        icon_hl = '@variable',       -- Highlight group for the icon
        desc = 'Files',              -- Description of the action
        group = 'Label',             -- Group for highlighting
        action = 'Telescope find_files',  -- Command to execute on shortcut press
        key = 'f',                   -- Keybinding for the shortcut
      },
      -- Apps shortcut
      {
        desc = ' Apps',             -- Description of the action
        group = 'DiagnosticHint',     -- Group for highlighting
        action = 'Telescope app',     -- Command to execute on shortcut press
        key = 'a',                    -- Keybinding for the shortcut
      },
      -- Dotfiles shortcut
      {
        desc = ' dotfiles',         -- Description of the action
        group = 'Number',            -- Group for highlighting
        action = 'Telescope dotfiles',  -- Command to execute on shortcut press
        key = 'd',                   -- Keybinding for the shortcut
      },
    },
  },
})
