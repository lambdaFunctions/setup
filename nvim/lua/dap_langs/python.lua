local dap = require("dap")
local dap_python = require("dap-python")

dap_python.setup("python")

dap_python.test_runner = "pytest"

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch current file",
    program = "${file}",
    pythonPath = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return venv .. "/bin/python"
      end
      return "python"
    end,
  },
}

