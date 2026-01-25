require("core.options")
require("core.plugins")
require("core.keymaps")

require("plugins.statusbar")
require("plugins.toggleterm")
require("plugins.mason")

vim.cmd("colorscheme rasmus")

require("lsp.lua_ls")
require("lsp.pyright")
require("lsp.rust_analyzer")
require("lsp.ts_ls")
require("lsp.general_config")                   -- Always the last to be imported.

require("core.dap_config")
require("dap_langs.python")
require("dap_langs.node")
require("dap_langs.rust")

require("custom.tabs")
require("custom.markdown")
require("custom.background")

