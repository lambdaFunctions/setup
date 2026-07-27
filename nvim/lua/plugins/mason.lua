return {
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    config = function()
      require("mason").setup({
          ui = {
            border = "single",
          },
    })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "pyright",
          "lua-language-server",
          "typescript-language-server",
          "rust-analyzer",
          "js-debug-adapter",
          "debugpy",
          "intelephense",
          "php-cs-fixer",
          "php-debug-adapter",
          "codelldb",
        },
        auto_update  = false,
        run_on_start = true,
      })
    end,
  },
}
