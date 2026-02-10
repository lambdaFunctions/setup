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

  root_dir = vim.fs.root(0, {
    "compile_commands.json",
    "compile_flags.txt",
    ".git",
  }),
}

vim.lsp.enable("clangd")

