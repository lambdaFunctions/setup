-- ----------------------------------- OPTIONS

vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = false
opt.number = true
vim.opt.path:append "**"
opt.wildoptions = pum

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- Disable any color customization and use default terminal color
vim.cmd("highlight Normal guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE")


-- ----------------------------------- KEYMAPS

vim.g.mapleader = " "

-- for conciseness
local keymap = vim.keymap 

keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "Open Explorer" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quite window" })

-- Split Screens
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) 
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) 
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) 
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) 
-- Move cursos between splits
-- keymap.set("n", "C-h", "<C-w>h", { desc = "Move focus to left" })
-- keymap.set("n", "C-l", "<C-w>l", { desc = "Move focus to right" })
-- keymap.set("n", "C-k", "<C-w>k", { desc = "Move focus up" })
-- keymap.set("n", "C-j", "<C-w>j", { desc = "Move focus bottom" })

-- Tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) 
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) 
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) 
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) 
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })


-- ----------------------------------- PLUGINS

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug("nvim-telescope/telescope.nvim")
Plug("nvim-lua/plenary.nvim")
Plug("DreamMaoMao/yazi.nvim")
Plug("prabirshrestha/vim-lsp")
Plug("mattn/vim-lsp-settings")
Plug("brooth/far.vim")
Plug("numToStr/FTerm.nvim")

vim.call('plug#end')

-- COLORSCHEME

vim.cmd('colorscheme minimal_dark_theme_color_theme_darker')

-- PLUGINS KEYMAPS

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- File Manager (Yazi)
keymap.set("n", "<leader>fy", "<cmd>Yazi<CR>", { desc = "Open yazi floating window" })

-- Terminal

require'FTerm'.setup({
    border = 'single',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})

vim.keymap.set('n', '<leader>j', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<ESC><leader>j', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')

-- PLUGINS LSP KEYMAPS
keymap.set("n", "<leader>lsh", "<cmd>LspHover<CR>", { desc = "Show floating hover window" }) 
keymap.set("n", "<leader>lsi", "<cmd>LspPeekImplementation<CR>", { desc = "Show implementation in floating window" }) 
keymap.set("n", "<leader>lsd", "<cmd>LspDefinition<CR>", { desc = "Go to definition in a new window" }) 
keymap.set("n", "<leader>lsw", "<cmd>LspReferences<CR>", { desc = "Show symbol references in a new window" }) 
keymap.set("n", "<leader>lw", "<cmd>LspRename<CR>", { desc = "Rename in entire opened file" }) 

-- LSPs
vim.lsp.enable('lua_ls')                -- brew install lua-language-server
vim.lsp.enable('rls')
-- vim.lsp.enable('rust-analyzer')      -- brew install rust-analyzer
vim.lsp.enable('pyright')               -- brew install pyright

