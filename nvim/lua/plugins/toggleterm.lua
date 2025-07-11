return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<leader>j", "<CMD>lua require('toggleterm').toggle()<CR>", desc = "Toggle terminal" },
    { "<ESC>", "<C-\\><C-n><CMD>lua require('toggleterm').toggle()<CR>", mode = "t" },
  },
  config = function()
    require("toggleterm").setup({
      direction = "horizontal",
      autochdir = true,
    })
  end,
}
