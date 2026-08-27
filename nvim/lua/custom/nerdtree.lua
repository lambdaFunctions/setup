vim.g.nerdtree_auto_open = false

local augroup = vim.api.nvim_create_augroup("NERDTreeAuto", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = function()
    if vim.g.nerdtree_auto_open and vim.fn.winnr("$") == 1 then
      vim.cmd("NERDTree")
      vim.cmd("wincmd p")
    end
  end,
})

vim.api.nvim_create_autocmd("TabNewEntered", {
  group = augroup,
  callback = function()
    if vim.g.nerdtree_auto_open then
      vim.cmd("NERDTree")
      vim.cmd("wincmd p")
    end
  end,
})

-- Always active: close NERDTree if it becomes the only window
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  callback = function()
    if vim.fn.winnr("$") == 1 and vim.bo.filetype == "nerdtree" then
      vim.schedule(function()
        vim.cmd("quit")
      end)
    end
  end,
})

vim.keymap.set("n", "<leader>tN", function()
  vim.g.nerdtree_auto_open = not vim.g.nerdtree_auto_open
  if vim.g.nerdtree_auto_open then
    vim.notify("NERDTree auto-open: ON", vim.log.levels.INFO)
  else
    vim.notify("NERDTree auto-open: OFF", vim.log.levels.WARN)
  end
end, { desc = "Toggle NERDTree auto-open" })
