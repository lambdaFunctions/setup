local dap = require("dap")
local dap_vscode_js = require("dap-vscode-js")

dap_vscode_js.setup({
  debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
  adapters = { "pwa-node", "pwa-chrome" },
})

for _, language in ipairs({ "javascript", "typescript" }) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch current file",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to Node (9229)",
      address = "127.0.0.1",
      port = 9229,
      cwd = vim.fn.getcwd(),
      restart = true,
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
    },
  }
end

