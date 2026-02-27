local M = {}

local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- Using git to identify the project's language
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
  if has_file(root, "pyproject.toml") then
    return "python"
  end

  if has_file(root, "go.mod") then
    return "go"
  end

  if has_file(root, "package.json") then
    return "node"
  end

  return "generic"
end

function M.setup()
  telescope.setup({
    defaults = {
      hidden = false,
      file_ignore_patterns = {
        "node_modules/",
        "dist/",
        "build/",
        "%.git/",
      },
    },
  })
end

function M.project_find_files()
  local root = get_root()
  local project = detect_project_type(root)

  local opts = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.70,
      },
    },
    cwd = root,
  }

  if project == "python" then
    opts.file_ignore_patterns = {
      "__pycache__/",
      "%.pyc",
      "%.venv/",
      "venv/",
      "%.mypy_cache/",
    }

  elseif project == "node" then
    opts.file_ignore_patterns = {
      "node_modules/",
      "dist/",
      "coverage/",
    }

  elseif project == "go" then
    opts.file_ignore_patterns = {
      "vendor/",
      "bin/",
    }
  end

  builtin.find_files(opts)
end

function M.project_live_grep()
  local root = get_root()
  local project = detect_project_type(root)

  local opts = {
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.70,
      },
    },
    cwd = root,
    additional_args = function()
      return { "--hidden" }
    end,
  }

  if project == "node" then
    opts.glob_pattern = "!node_modules/*"
  elseif project == "python" then
    opts.glob_pattern = "!.venv/*"
  elseif project == "go" then
    opts.glob_pattern = "!vendor/*"
  end

  builtin.live_grep(opts)
end

-- Shared finder (.env files, etc.) for all languages
function M.find_all_files()
  builtin.find_files({
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.70,
      },
    },
    cwd = get_root(),
    hidden = true,
    no_ignore = true,
    file_ignore_patterns = {},
  })
end

return M
