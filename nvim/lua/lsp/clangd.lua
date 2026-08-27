vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--suggest-missing-includes",
  },

  filetypes = { "c", "cpp", "objc", "objcpp" },

  root_dir = function(bufnr, on_dir)
    on_dir(vim.fs.root(bufnr, {
      "compile_commands.json",
      "compile_flags.txt",
      ".git",
    }))
  end,
}

vim.lsp.enable("clangd")

