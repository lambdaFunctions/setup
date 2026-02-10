vim.lsp.config.gopls = {
  cmd = { "gopls" },

  filetypes = { "go", "gomod", "gowork", "gotmpl" },

  root_dir = vim.fs.root(0, {
    "go.work",
    "go.mod",
    ".git",
  }),

  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
        nilness = true,
        shadow = true,
        unusedwrite = true,
      },
      staticcheck = true,
    },
  },
}

vim.lsp.enable("gopls")

