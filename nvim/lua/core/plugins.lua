local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug("kvrohit/rasmus.nvim")
Plug("AlexvZyl/nordic.nvim")
Plug("akinsho/toggleterm.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("DreamMaoMao/yazi.nvim")
-- Plug("tribela/vim-transparent")
Plug("nvim-lualine/lualine.nvim")
Plug("neovim/nvim-lspconfig")
Plug("mfussenegger/nvim-dap")
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

-- setup adapters
require('dap-vscode-js').setup({
    debugger_cmd = { 'js-debug-adapter' },
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
})

local dap = require('dap')

-- custom adapter for running tasks before starting debug
local custom_adapter = 'pwa-node-custom'
dap.adapters[custom_adapter] = function(cb, config)
    if config.preLaunchTask then
        local async = require('plenary.async')
        local notify = require('notify').async

        async.run(function()
            ---@diagnostic disable-next-line: missing-parameter
            notify('Running [' .. config.preLaunchTask .. ']').events.close()
        end, function()
            vim.fn.system(config.preLaunchTask)
            config.type = 'pwa-node'
            dap.run(config)
        end)
    end
end

-- language config
for _, language in ipairs({ 'typescript', 'javascript' }) do
    dap.configurations[language] = {
        {
            name = 'Launch',
            type = 'pwa-node',
            request = 'launch',
            program = '${file}',
            rootPath = '${workspaceFolder}',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            name = 'Attach to node process',
            type = 'pwa-node',
            request = 'attach',
            rootPath = '${workspaceFolder}',
            processId = require('dap.utils').pick_process,
        },
        {
            name = 'Debug Main Process (Electron)',
            type = 'pwa-node',
            request = 'launch',
            program = '${workspaceFolder}/node_modules/.bin/electron',
            args = {
                '${workspaceFolder}/dist/index.js',
            },
            outFiles = {
                '${workspaceFolder}/dist/*.js',
            },
            resolveSourceMapLocations = {
                '${workspaceFolder}/dist/**/*.js',
                '${workspaceFolder}/dist/*.js',
            },
            rootPath = '${workspaceFolder}',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
        {
            name = 'Compile & Debug Main Process (Electron)',
            type = custom_adapter,
            request = 'launch',
            preLaunchTask = 'npm run build-ts',
            program = '${workspaceFolder}/node_modules/.bin/electron',
            args = {
                '${workspaceFolder}/dist/index.js',
            },
            outFiles = {
                '${workspaceFolder}/dist/*.js',
            },
            resolveSourceMapLocations = {
                '${workspaceFolder}/dist/**/*.js',
                '${workspaceFolder}/dist/*.js',
            },
            rootPath = '${workspaceFolder}',
            cwd = '${workspaceFolder}',
            sourceMaps = true,
            skipFiles = { '<node_internals>/**' },
            protocol = 'inspector',
            console = 'integratedTerminal',
        },
    }
end

