-- Core Settings
require("core.options")
require("core.plugins")
require("core.keymaps")

-- Colorscheme
vim.cmd("colorscheme minimal_dark_theme_color_theme_darker")
-- vim.cmd("colorscheme cold")

-- LSP Config
require("lsp.lua_ls")
require("lsp.rust_analyzer")
require("lsp.pyright")

