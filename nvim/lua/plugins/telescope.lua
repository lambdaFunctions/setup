-- ── Helpers ──────────────────────────────────────────────────────────────────

local function get_root()
  return vim.fs.dirname(
    vim.fs.find(
      { ".git", "pyproject.toml", "go.mod", "package.json" },
      { upward = true }
    )[1]
  ) or vim.fn.getcwd()
end

local function has_file(root, name)
  return vim.fn.filereadable(root .. "/" .. name) == 1
end

local function detect_project_type(root)
  if has_file(root, "pyproject.toml") then return "python" end
  if has_file(root, "go.mod")         then return "go"     end
  if has_file(root, "package.json")   then return "node"   end
  return "generic"
end

local shared_layout = {
  sorting_strategy = "ascending",
  layout_config = { horizontal = { prompt_position = "top", preview_width = 0.50 } },
}

local function project_find_files()
  local builtin = require("telescope.builtin")
  local root    = get_root()
  local opts    = vim.tbl_extend("force", shared_layout, { cwd = root })

  local ignore = {
    python = { "__pycache__/", "%.pyc", "%.venv/", "venv/", "%.mypy_cache/" },
    node   = { "node_modules/", "dist/", "coverage/" },
    go     = { "vendor/", "bin/" },
  }
  opts.file_ignore_patterns = ignore[detect_project_type(root)]

  builtin.find_files(opts)
end

local function project_live_grep()
  local builtin = require("telescope.builtin")
  local root    = get_root()
  local opts    = vim.tbl_extend("force", shared_layout, {
    cwd = root,
    additional_args = function() return { "--hidden" } end,
  })

  local globs = { node = "!node_modules/*", python = "!.venv/*", go = "!vendor/*" }
  opts.glob_pattern = globs[detect_project_type(root)]

  builtin.live_grep(opts)
end

local function find_all_files()
  local builtin = require("telescope.builtin")
  builtin.find_files(vim.tbl_extend("force", shared_layout, {
    cwd = get_root(),
    hidden = true,
    no_ignore = true,
    file_ignore_patterns = {},
  }))
end

local function open_in_tabs(prompt_bufnr)
  local actions      = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local picker       = action_state.get_current_picker(prompt_bufnr)
  local entries      = picker:get_multi_selection()

  if vim.tbl_isempty(entries) then
    local cur = action_state.get_selected_entry()
    if cur then entries = { cur } end
  end

  actions.close(prompt_bufnr)

  for _, entry in ipairs(entries) do
    local filename = entry.filename or entry.path or entry.value
    if filename and filename ~= "" then
      local cmd = "tabedit " .. vim.fn.fnameescape(filename)
      if entry.lnum then cmd = "tabedit +" .. entry.lnum .. " " .. vim.fn.fnameescape(filename) end
      vim.cmd(cmd)
    else
      vim.notify("Could not open file: no valid filename", vim.log.levels.WARN)
    end
  end
end

-- ── Spec ─────────────────────────────────────────────────────────────────────

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", project_find_files, desc = "Find files (project-aware)" },
    { "<leader>fg", project_live_grep,  desc = "Live grep (project-aware)" },
    { "<leader>fa", find_all_files,     desc = "Find ALL files (hidden + ignored)" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        hidden = false,
        layout_config = { width = 0.90, height = 0.90 },
        file_ignore_patterns = { "node_modules/", "dist/", "build/", "%.git/" },
        preview = {
          treesitter = { disable = { "markdown" } },
        },
        mappings = {
          i = { ["<C-t>"] = open_in_tabs },
          n = { ["<C-t>"] = open_in_tabs },
        },
      },
    })
  end,
}
