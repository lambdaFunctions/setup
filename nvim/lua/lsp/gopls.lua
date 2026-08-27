vim.lsp.config.gopls = {
  cmd = { "gopls" },

  filetypes = { "go", "gomod", "gowork", "gotmpl" },

  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, {
      "go.work",
      "go.mod",
      ".git",
    }))
  end,

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

