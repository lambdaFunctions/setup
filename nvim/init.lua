-- Core Settings
require("core.options")
require("core.plugins")
require("core.keymaps")

-- Colorscheme
vim.cmd("colorscheme nordic")

-- Colorscheme: Config
require('nordic').setup({
    italic_comments = false,
    -- Enable editor background transparency.
    transparent = {
        -- Enable transparent background.
        bg = true,
        -- Enable transparent background for floating windows.
        float = true,
    },
    -- Enable brighter float border.
    bright_border = false,
    -- Reduce the overall amount of blue in the theme (diverges from base Nord).
    reduced_blue = false,
    -- Swap the dark background with the normal one.
    swap_backgrounds = false,
    -- Cursorline options.  Also includes visual/selection.
    cursorline = {
        -- Bold font in cursorline.
        bold = false,
        -- Bold cursorline number.
        bold_number = true,
    },
    noice = {
        -- Available styles: `classic`, `flat`.
        style = 'flat',
    },
    telescope = {
        -- Available styles: `classic`, `flat`.
        style = 'flat',
    },
    leap = {
        -- Dims the backdrop when using leap.
        dim_backdrop = false,
    },
    ts_context = {
        -- Enables dark background for treesitter-context window
        dark_background = true,
    }
})

vim.cmd("colorscheme nordic")

-- Colorscheme: Tabs
vim.api.nvim_set_hl(0, "TabLineSel", {
    fg = "#000000",
    bg = "#f8f8f8",
    bold = false,
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

-- Markdown Files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.textwidth = 80
  end,
})

-- LSP Config
require("lsp.lua_ls")
require("lsp.rust_analyzer")
require("lsp.pyright")

