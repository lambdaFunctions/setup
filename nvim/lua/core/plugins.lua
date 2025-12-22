local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug("akinsho/toggleterm.nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("DreamMaoMao/yazi.nvim")
Plug("prabirshrestha/vim-lsp")
Plug("mattn/vim-lsp-settings")
Plug("tribela/vim-transparent")
Plug("nvim-lualine/lualine.nvim")
Plug("kvrohit/rasmus.nvim")
Plug("Mofiqul/vscode.nvim")
Plug("Ronxvier/ymir.nvim")
Plug("ydkulks/cursor-dark.nvim")
Plug("rmehri01/onenord.nvim")
Plug("AlexvZyl/nordic.nvim")
Plug("nvim-tree/nvim-tree.lua")

vim.call('plug#end')


-- Vim Tree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})


