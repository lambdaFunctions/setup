local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug("kvrohit/rasmus.nvim")
Plug("AlexvZyl/nordic.nvim")
Plug("akinsho/toggleterm.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("DreamMaoMao/yazi.nvim")
Plug("nvim-lualine/lualine.nvim")
Plug("neovim/nvim-lspconfig")
Plug("mfussenegger/nvim-dap")
Plug("rcarriga/nvim-dap-ui")
Plug("nvim-neotest/nvim-nio")       -- required by dap-ui
Plug("mxsdev/nvim-dap-vscode-js")

vim.call('plug#end')

-- Terminal
require("toggleterm").setup({ size = 20, direction = "horizontal", autochdir = true })

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

