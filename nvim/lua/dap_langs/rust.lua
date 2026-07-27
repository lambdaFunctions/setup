local dap = require('dap')

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
    args = { '--port', '${port}' },
  },
}

local function default_executable()
  local cwd = vim.fn.getcwd()
  local pkg_name = nil
  local cargo_toml = io.open(cwd .. '/Cargo.toml', 'r')
  if cargo_toml then
    for line in cargo_toml:lines() do
      pkg_name = line:match('^name%s*=%s*"(.+)"')
      if pkg_name then break end
    end
    cargo_toml:close()
  end
  local default_path = cwd .. '/target/debug/' .. (pkg_name or '')
  return vim.fn.input('Path to executable: ', default_path, 'file')
end

dap.configurations.rust = {
  {
    name = 'Launch (cargo build)',
    type = 'codelldb',
    request = 'launch',
    program = function()
      local build_output = vim.fn.system('cargo build')
      if vim.v.shell_error ~= 0 then
        error('cargo build failed:\n' .. build_output)
      end
      return default_executable()
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    sourceLanguages = { 'rust' },
  },
}

dap.configurations.cpp = dap.configurations.rust
dap.configurations.c = dap.configurations.rust
