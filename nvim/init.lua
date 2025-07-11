-- Core Settings
require("core.options")
require("core.plugins")
require("core.keymaps")

-- Colorscheme
-- vim.cmd("colorscheme vscode")
vim.cmd("colorscheme rasmus")

-- Status Bar
require("lualine").setup {
    icons_enabled = false,
    theme = 'auto', 
}

-- LSP Config
require("lsp.lua_ls")
require("lsp.rust_analyzer")
require("lsp.pyright")

