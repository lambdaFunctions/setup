local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("core.options")
require("core.keymaps")

require("lazy").setup("plugins", {
  change_detection = { enabled = false, notify = false },
})

require("lsp.lua_ls")
require("lsp.pyright")
require("lsp.clangd")
require("lsp.gopls")
require("lsp.intelephense")
require("lsp.rust_analyzer")
require("lsp.ts_ls")
require("lsp.general_config")

require("custom.tabs")
require("custom.markdown")
require("custom.background")
require("custom.linenumber")
require("custom.nerdtree")
