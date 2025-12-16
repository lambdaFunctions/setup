-- Core Settings
require("core.options")
require("core.plugins")
require("core.keymaps")

-- Colorscheme
vim.cmd("colorscheme cursor-dark-midnight")

-- Colorscheme: Tabs
vim.api.nvim_set_hl(0, "TabLineSel", {
    fg = "#000000",
    bg = "#f8f8f8",
    bold = true,
})
  
vim.api.nvim_set_hl(0, "TabLineFill", {
    bg = "#111111",
})

-- Status Bar
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = 'iceberg_dark', 
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '|', right = '|' },
    },
    sections = {
        lualine_c = { { 'filename', path = 3 }, 'filesize' },
        lualine_x = { 'filezie', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
    }
})

-- LSP Config
require("lsp.lua_ls")
require("lsp.rust_analyzer")
require("lsp.pyright")

