vim.lsp.config.intelephense = {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, { "composer.json", ".git" }))
  end,
  settings = {
    intelephense = {
      files = {
        maxSize = 1000000,
      },
    },
  },
}

vim.lsp.enable("intelephense")
