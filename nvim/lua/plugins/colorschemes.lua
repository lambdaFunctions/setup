return {
  { "kvrohit/rasmus.nvim",            lazy = true },
  { "projekt0n/github-nvim-theme",    lazy = true },
  {
    "aktersnurra/no-clown-fiesta.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme no-clown-fiesta")
    end,
  }
}
