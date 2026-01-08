---@brief
---
--- https://github.com/microsoft/pyright
---
--- `pyright`, a static type checker and language server for python

local PythonSetup = {}

local function get_python_path(root_dir)
    local venv = root_dir .. "/venv"
    local python_bin = venv .. "/bin/python"

    if vim.fn.executable(python_bin) == 1 then
        return python_bin
    end

    return "usr/bin/python3"
end

local function detect_venv(root_dir)
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV
    end

    for _, dir in ipairs({ "venv", }) do
        local path = root_dir .. "/" .. dir
        if vim.fn.isdirectory(path) == 1 then
            return path
        end
    end

    return nil
end

function PythonSetup.setup()
    local root_dir = vim.fn.getcwd()
    local python_path = get_python_path(root_dir)
    local venv = detect_venv(root_dir)

    vim.lsp.start({
        name = "pyright",
        cmd = {"pyright-langserver", "--stdio" },
        root_dir = vim.fs.dirname(
            vim.fs.find({ "pyrightconfig.json" }, { upward = true })[1]
        ),
        settings = {
            python = {
                analysis = {
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                },
                pythonPath = python_path,
            },
        },
    })
end

vim.lsp.enable("pyright")

return PythonSetup

