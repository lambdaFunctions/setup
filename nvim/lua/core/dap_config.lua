local dap = require("dap")
local dapui = require("dapui")

vim.fn.sign_define("DapBreakpoint", { text = "*", texthl = "SignColumn", linehl = "", numhl = "" })

dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.3 },
        { id = "breakpoints", size = 0.15 },
        { id = "stacks", size = 0.2 },
        { id = "watches", size = 0.2 },
        { id = "console", size = 0.15 },
      },
      size = 0.5,
      position = "right",
    },
    {
      elements = {
        "repl",
      },
      size = 20,
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

dap.listeners.after.event_output["dapui"] = function(session, body)
  if body.category == "console" then
    vim.schedule(function()
      require("dapui").eval(body.output)
    end)
  end
end

