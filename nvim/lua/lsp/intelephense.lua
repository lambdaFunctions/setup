vim.lsp.config.intelephense = {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_dir = vim.fs.root(0, { "composer.json", ".git" }),
  settings = {
    intelephense = {
      files = {
        maxSize = 1000000,
      },
    },
  },
}

vim.lsp.enable("intelephense")
