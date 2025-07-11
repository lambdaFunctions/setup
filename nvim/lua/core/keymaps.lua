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

-- file manager (lazy-loads yazi via the Yazi command)
keymap.set("n", "<leader>fy", "<cmd>Yazi<CR>", { desc = "Open Yazi" })
keymap.set("n", "<leader>-", "<cmd>NERDTreeToggle<CR>", { desc = "Toggle NERDTree" })
keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })

-- Copy buffer's absolute path (e.g., /home/user/project/src/main.go)
keymap.set('n', '<leader>cp', function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  vim.notify('Copied absolute path', vim.log.levels.INFO)
end, { desc = 'Yank absolute path' })

-- Copy buffer's filename only (e.g., main.go)
keymap.set('n', '<leader>cn', function()
  vim.fn.setreg('+', vim.fn.expand('%:t'))
  vim.notify('Copied file name', vim.log.levels.INFO)
end, { desc = 'Yank file name' })

-- LSP diagnostics toggle
keymap.set("n", "<leader>td", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
    vim.notify("LSP messages: OFF", vim.log.levels.WARN)
  else
    vim.diagnostic.enable(true)
    vim.notify("LSP messages: ON", vim.log.levels.INFO)
  end
end, { desc = "Toggle ALL LSP messages" })

keymap.set("n", "gti", "<cmd>tab split | lua vim.lsp.buf.implementation()<CR>")
keymap.set("n", "gtd", "<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>")

-- Terminal, Telescope, and DAP keymaps are defined in their plugin specs.
