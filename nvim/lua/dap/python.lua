local dap = require("dap")

local function detect_venv(root_dir)
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV
  end

  for _, dir in ipairs({ "venv", ".venv" }) do
    local path = root_dir .. "/" .. dir
    if vim.fn.isdirectory(path) == 1 then
      return path
    end
  end

  return nil
end

local function get_python_path(root_dir)
  local venv = detect_venv(root_dir)
  if venv then
    local python = venv .. "/bin/python"
    if vim.fn.executable(python) == 1 then
      return python
    end
  end

  return vim.fn.exepath("python3")
end

dap.adapters.python = function(cb, _)
  local root = vim.fn.getcwd()
  local python = get_python_path(root)

  cb({
    type = "executable",
    command = python,              -- always a string
    args = { "-m", "debugpy.adapter" },
  })
end

dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Run current file",
    program = "${file}",
    cwd = "${workspaceFolder}",
    console = "integratedTerminal",
    justMyCode = true,
  },
  {
    type = "python",
    request = "attach",
    name = "Attach to running process",
    connect = function()
      local host = vim.fn.input("Host [127.0.0.1]: ")
      host = host ~= "" and host or "127.0.0.1"
      local port = tonumber(vim.fn.input("Port: "))
      return { host = host, port = port }
    end,
  },
}

