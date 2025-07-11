return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "rust", "typescript", "javascript", "tsx",
        "python", "c", "cpp", "go", "php",
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true, disable = { "markdown", "markdown_inline" } },
      indent    = { enable = true },
    })
  end,
}
