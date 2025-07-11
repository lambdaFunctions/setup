return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
      "mfussenegger/nvim-dap-python",
      "mxsdev/nvim-dap-vscode-js",
      "leoluz/nvim-dap-go",
    },
    keys = {
      { "<F5>",       function() require("dap").continue()          end, desc = "DAP Continue" },
      { "<F10>",      function() require("dap").step_over()         end, desc = "DAP Step Over" },
      { "<F11>",      function() require("dap").step_into()         end, desc = "DAP Step Into" },
      { "<F12>",      function() require("dap").step_out()          end, desc = "DAP Step Out" },
      { "<leader>b",  function() require("dap").toggle_breakpoint() end, desc = "DAP Breakpoint" },
      { "<leader>dr", function() require("dap").repl.open()         end, desc = "DAP REPL" },
      { "<leader>dl", function() require("dap").run_last()          end, desc = "DAP Run Last" },
      { "<leader>du", function() require("dapui").toggle()          end, desc = "DAP UI Toggle" },
    },
    config = function()
      require("core.dap_config")
      require("dap_langs.python")
      require("dap_langs.node")
      require("dap_langs.rust")
      require("dap_langs.go")
      require("dap_langs.php")
    end,
  },
}
