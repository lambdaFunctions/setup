local function set_cursorline_highlight()
  vim.api.nvim_set_hl(0, "CursorLineNr", {
    fg = "#ffd700",
    bold = true,
  })
end

-- Apply immediately (in case colorscheme already loaded)
set_cursorline_highlight()

-- Reapply every time colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_cursorline_highlight,
})

