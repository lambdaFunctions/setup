local dap = require("dap")

for _, language in ipairs({
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
}) do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
    },

    {
      type = "pwa-node",
      request = "launch",
      name = "pnpm dev",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "pnpm",
      runtimeArgs = { "run", "dev" },
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      sourceMaps = true,
      protocol = "inspector",
    },

    {
      type = "pwa-node",
      request = "attach",
      name = "Attach to process",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
  }
end

