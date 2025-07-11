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
  -- Remote attach configuration for Docker
  {
    type = "python",
    request = "attach",
    name = "Attach to Docker",
    connect = {
      host = "127.0.0.1",  -- or the IP of your Docker host
      port = 5678,          -- default debugpy port
    },
    -- Path mappings between host and container
    pathMappings = {
      {
        localRoot = "${workspaceFolder}",  -- Your local project root
        remoteRoot = "/app",                -- Where code lives in container
      },
    },
    justMyCode = true,
  },
}

-- Configuration for docker-compose with different path
-- dap.configurations.python[#dap.configurations.python + 1] = {
--   type = "python",
--   request = "attach",
--   name = "Attach to Docker (custom path)",
--   connect = {
--     host = "127.0.0.1",
--     port = 5678,
--   },
--   pathMappings = {
--     {
--       localRoot = "${workspaceFolder}",
--       remoteRoot = "/usr/src/app",  -- Common alternative path
--     },
--   },
--   justMyCode = true,
-- }

