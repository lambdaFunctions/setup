-- Core Settings
require("core.options")
require("core.plugins")
require("core.keymaps")

-- LSP Config
require("lsp.lua_ls")
require("lsp.rust_analyzer")
require("lsp.pyright")

-- Colorscheme
vim.cmd("colorscheme nordic")

-- Colorscheme: Tabs
vim.api.nvim_set_hl(0, "TabLineSel", {
    fg = "#000000",
    bg = "#f8f8f8",
    bold = false,
})

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#111111" })

-- Markdown Files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
  end,
})

