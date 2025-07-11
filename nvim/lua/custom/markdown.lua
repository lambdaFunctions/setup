-- Set local options for Markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 85
    vim.treesitter.stop()
  end,
})

-- Apply custom highlights for code elements
local function apply_markdown_colors()
  -- Inline code: light blue (single backticks)
  vim.api.nvim_set_hl(0, "markdownCode", { fg = "#A6C8FF" })

  -- Fenced code blocks: soft off‑white
  -- (often uses the same group as inline code, so we'll set both for safety)
  vim.api.nvim_set_hl(0, "markdownCodeBlock", { fg = "#B0B0B0" })

  -- Blockquote marker (>): orange
  vim.api.nvim_set_hl(0, "markdownBlockquote", { fg = "#FF9E3B" })
end

-- Run on Markdown file load and after any colorscheme change
vim.api.nvim_create_autocmd({ "FileType", "ColorScheme" }, {
  pattern = { "markdown", "*" },
  callback = function()
    -- Small delay ensures syntax groups are fully defined
    vim.schedule(apply_markdown_colors)
  end,
})

