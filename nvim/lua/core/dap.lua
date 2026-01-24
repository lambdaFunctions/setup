local dap = require("dap")
local dapui = require("dapui")

require("dap-vscode-js").setup({
  debugger_path = vim.fn.stdpath("data") .. "/vscode-js-debug",
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge" },
})

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.35 },
        { id = "breakpoints", size = 0.15 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 10,
      position = "bottom",
    },
  },
})

-- Open/close automatically
dap.listeners.after.event_initialized["dapui"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui"] = function()
  dapui.close()
end

require("dap.python")
require("dap.typescript")

