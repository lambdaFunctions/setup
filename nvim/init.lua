-- Core Settings
require("core.options")
require("core.plugins")
require("core.keymaps")

-- Colorscheme
vim.cmd("colorscheme nordic")

-- LSP
require("lsp.lua_ls")
require("lsp.pyright")
require("lsp.rust_analyzer")
require("lsp.general_config")                   -- Always the last to be imported.

-- Custom Config (Plugins, native vim, etc.)
require("custom.tabs")
require("custom.markdown")

