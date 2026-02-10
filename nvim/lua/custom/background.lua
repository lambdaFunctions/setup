local function smart_background_change(color_hex, transparent)
  local bg_value = transparent and "none" or color_hex
  
  -- List of highlight groups that primarily control background areas
  local background_groups = {
    "Normal", "NormalFloat", "NormalNC",
    "SignColumn", "LineNr", "CursorLineNr",
    "Folded", "FoldColumn",
    "EndOfBuffer",  -- ~ lines at end of buffer
    "WinSeparator", "VertSplit",  -- Window separators
    "FloatBorder",  -- Floating window borders
    "StatusLine", "StatusLineNC", "TabLine", "TabLineFill",
    "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",  -- Popup menu
    -- "QuickFixLine", "Visual", "VisualNOS",  -- Selection
    -- "CursorLine", "CursorColumn", "ColorColumn",
    -- "MatchParen",  -- Matching parentheses
  }
  
  -- Change ONLY the background for each group
  for _, group in ipairs(background_groups) do
    -- Get current highlight settings
    local current = vim.api.nvim_get_hl(0, { name = group })
    
    -- Create new settings preserving everything except background
    local new_settings = vim.tbl_extend("force", current, {
      bg = bg_value,
      ctermbg = nil, -- Clear terminal background
    })
    
    vim.api.nvim_set_hl(0, group, new_settings)
  end
end

smart_background_change("#0d0d0d", false)  -- Solid color
-- smart_background_change("#090909", false)  -- Solid color

