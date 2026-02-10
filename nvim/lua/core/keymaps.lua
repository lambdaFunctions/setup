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

-- Insert Mode Commands
vim.keymap.set("i", "{", function()
  -- Insert opening brace
  vim.api.nvim_put({ "{" }, "c", true, true)

  -- New line and indent
  vim.cmd("normal! o")
  vim.cmd("normal! ==")

  -- Insert closing brace on a new line
  vim.cmd("normal! o}")
  vim.cmd("normal! ==")

  -- Move cursor back inside the block
  vim.cmd("normal! k")
end, { noremap = true, silent = true })

-- file manager
keymap.set("n", "<leader>fy", "<cmd>Yazi<CR>", { desc = "Open Yazi" })

-- Terminal
keymap.set('n', '<leader>j', '<CMD>lua require("ToggleTerm").toggle()<CR>')
keymap.set('t', '<ESC>', '<C-\\><C-n><CMD>lua require("ToggleTerm").toggle()<CR>')

-- Telescope bindings
keymap.set('n', '<Leader>ff', ':lua require("telescope.builtin").find_files({ hidden = true })<CR>', { noremap = true, silent = true })
keymap.set('n', '<Leader>fg', ':lua require("telescope.builtin").live_grep({ additional_args = { "--hidden" } } )<CR>', { noremap = true, silent = true })

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

-- LSP - Go to
vim.keymap.set('n', 'gti', '<cmd>tab split | lua vim.lsp.buf.implementation()<CR>', { desc = '' })
vim.keymap.set("n", "gtd", "<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>", { desc = '' })

-- DAP
local dap = require("dap")
keymap.set("n", "<F5>", dap.continue)
keymap.set("n", "<F10>", dap.step_over)
keymap.set("n", "<F11>", dap.step_into)
keymap.set("n", "<F12>", dap.step_out)
keymap.set("n", "<leader>b", dap.toggle_breakpoint)

-- DAP UI
local dapui = require("dapui")
keymap.set("n", "<leader>du", dapui.toggle)

