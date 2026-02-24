---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

local PythonSetup = {}

local function file_exists(path)
    return vim.fn.filereadable(path) == 1
end

local function is_poetry_project(root_dir)
    return file_exists(root_dir .. "/pyproject.toml")
end

local function get_poetry_venv(root_dir)
    if not is_poetry_project(root_dir) then
        return nil
    end

    local handle = io.popen("cd " .. root_dir .. " && poetry env info -p 2>/dev/null")
    if not handle then
        return nil
    end

    local result = handle:read("*a")
    handle:close()

    if result and result ~= "" then
        return vim.fn.trim(result)
    end

    return nil
end

local function detect_local_venv(root_dir)
    for _, dir in ipairs({ "venv", ".venv" }) do
        local path = root_dir .. "/" .. dir
        if vim.fn.isdirectory(path) == 1 then
            return path
        end
    end
    return nil
end

local function resolve_python_environment(root_dir)
    -- 1. Activated shell venv
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV
    end

    -- 2. Poetry venv
    local poetry_venv = get_poetry_venv(root_dir)
    if poetry_venv then
        return poetry_venv
    end

    -- 3. Local .venv or venv folder
    local local_venv = detect_local_venv(root_dir)
    if local_venv then
        return local_venv
    end

    return nil
end

function PythonSetup.setup()
    local root_dir = vim.fs.dirname(
        vim.fs.find({ "pyproject.toml", "pyrightconfig.json", ".git" }, { upward = true })[1]
    ) or vim.fn.getcwd()

    local venv_path = resolve_python_environment(root_dir)

    local python_settings = {
        analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
        },
    }

    if venv_path then
        python_settings.venvPath = vim.fn.fnamemodify(venv_path, ":h")
        python_settings.venv = vim.fn.fnamemodify(venv_path, ":t")
    else
        python_settings.pythonPath = "/usr/bin/python3"
    end

    vim.lsp.start({
        name = "pyright",
        cmd = { "pyright-langserver", "--stdio" },
        root_dir = root_dir,
        settings = {
            python = python_settings,
        },
    })
end

return PythonSetup

