-- Core Settings
require("core.options")
require("core.plugins")
require("core.keymaps")

-- Colorscheme
vim.cmd("colorscheme rasmus")

-- LSP
require("lsp.lua_ls")
require("lsp.pyright")
require("lsp.rust_analyzer")
require("lsp.ts_ls")
require("lsp.general_config")                   -- Always the last to be imported.

-- DAP
require("core.dap")

-- Custom Config (Plugins, native vim, etc.)
require("custom.tabs")
require("custom.markdown")
require("custom.background")

