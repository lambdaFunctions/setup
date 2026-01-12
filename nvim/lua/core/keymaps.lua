vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "Open Explorer" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
keymap.set("n", "<leader>nh", "<cmd>noh<CR>", { desc = "Clear highlight" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal split" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Buffer to tab" })

-- file manager
keymap.set("n", "<leader>fy", "<cmd>Yazi<CR>", { desc = "Open Yazi" })

-- Terminal
require("toggleterm").setup{ direction = "float", autochdir = true }
keymap.set('n', '<leader>j', '<CMD>lua require("ToggleTerm").toggle()<CR>')
keymap.set('t', '<ESC>', '<C-\\><C-n><CMD>lua require("ToggleTerm").toggle()<CR>')

-- Telescope bindings
keymap.set('n', '<Leader>ff', ':lua require("telescope.builtin").find_files({ hidden = true })<CR>', { noremap = true, silent = true })
keymap.set('n', '<Leader>fg', ':lua require("telescope.builtin").live_grep({ additional_args = { "--hidden" } } )<CR>', { noremap = true, silent = true })

-- One line: open new tab and run gri
vim.keymap.set('n', 'gti', '<cmd>tab split | lua vim.lsp.buf.implementation()<CR>', { desc = '' })
vim.keymap.set("n", "gtd", "<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>", { desc = '' })
-- keymap.set("n", "<leader>gt", "<cmd>tab split | LspDefinition<CR>", { desc = "Go to definition in current window" })

-- LSP
keymap.set('n', '<leader>td', function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.disable()
    vim.notify("LSP messages: OFF", vim.log.levels.WARN)
  else
    vim.diagnostic.enable()
    vim.notify("LSP messages: ON", vim.log.levels.INFO)
  end
end, { desc = 'Toggle ALL LSP messages' })

