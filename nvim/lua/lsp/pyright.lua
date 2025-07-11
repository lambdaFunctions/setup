vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_dir = vim.fs.root(0, { "pyrightconfig.json", "pyproject.toml", ".git" }),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
  before_init = function(_, config)
    local venv = vim.env.VIRTUAL_ENV
    if not venv then
      local root = config.root_dir or vim.fn.getcwd()
      for _, name in ipairs({ ".venv", "venv" }) do
        if vim.fn.isdirectory(root .. "/" .. name) == 1 then
          venv = root .. "/" .. name
          break
        end
      end
    end
    if not venv then
      local root = config.root_dir or vim.fn.getcwd()
      local poetry_path = vim.trim(vim.fn.system("cd " .. vim.fn.shellescape(root) .. " && poetry env info --path 2>/dev/null"))
      if poetry_path ~= "" and vim.fn.isdirectory(poetry_path) == 1 then
        venv = poetry_path
      end
    end
    if venv then
      config.settings.python.pythonPath = venv .. "/bin/python"
    end
  end,
}

vim.lsp.enable("pyright")
