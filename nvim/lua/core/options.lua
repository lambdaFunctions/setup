vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.wildoptions = "pum"
opt.path:append("**")
opt.cursorline = false 
opt.wrap = false
opt.swapfile = false
opt.signcolumn = "yes"      -- Avoid the LSP Warnings/Errors from shifting the number column

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

-- search
opt.smartcase = true

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- window splits
opt.splitright = true
opt.splitbelow = true

-- Terminal
-- Disable any color customization and use default terminal color
-- Note: Comment the line below when you want to user third-party themes other
-- that not the one mentioned in the 'setup' documentation.
-- vim.cmd("highlight Normal guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE")
opt.termguicolors = true

-- Tabname
function _G.get_tabline()
    local s = ""
    for tabnr = 1, vim.fn.tabpagenr("$") do
        local winnr = vim.fn.tabpagewinnr(tabnr)
        local buflist = vim.fn.tabpagebuflist(tabnr)[winnr]
        local bufname = vim.fn.bufname(buflist)
        local bufname_short = vim.fn.fnamemodify(bufname, ":t")
        if tabnr == vim.fn.tabpagenr() then
            s = s .. "%#TabLineSel#" .. " " .. tabnr .. ": " .. bufname_short .. " "
        else
            s = s .. "%#TabLine#" .. " " .. tabnr .. ": " .. bufname_short .. " "
        end
    end
    s = s .. "%#TabLineFill#"
    return s
end

vim.o.tabline = "%!v:lua.get_tabline()"

-- Toggle LSP diagnostics (comprehensive)
-- local M = {}
-- 
-- -- remember original handler so we can restore behaviour
-- M._orig_pub = vim.lsp.handlers["textDocument/publishDiagnostics"]
-- M._enabled = true
-- 
-- local function buf_from_result(result)
--   if not result or not result.uri then return nil end
--   local bufnr = vim.uri_to_bufnr(result.uri)
--   if bufnr and bufnr > 0 then return bufnr end
--   return nil
-- end
-- 
-- local function close_all_floats()
--   for _, win in ipairs(vim.api.nvim_list_wins()) do
--     local ok, cfg = pcall(vim.api.nvim_win_get_config, win)
--     if ok and cfg and cfg.relative and cfg.relative ~= "" then
--       -- it's a floating window — close it
--       pcall(vim.api.nvim_win_close, win, true)
--     end
--   end
-- end
-- 
-- -- override LSP publishDiagnostics handler
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
--   if M._enabled then
--     -- normal behavior
--     return M._orig_pub(err, result, ctx, config)
--   else
--     -- when disabled: clear diagnostics for the affected buffer
--     local bufnr = buf_from_result(result) or (ctx and ctx.bufnr)
--     if bufnr and vim.api.nvim_buf_is_loaded(bufnr) then
--       -- clear all diagnostics in that buffer
--       vim.diagnostic.clear(nil, bufnr)
--     end
--     -- drop diagnostics (do not call original)
--     return
--   end
-- end
-- 
-- -- toggle function
-- function M.toggle()
--   M._enabled = not M._enabled
-- 
--   if M._enabled then
--     -- re-enable rendering: set config to show desired components and re-show diagnostics
--     vim.diagnostic.config({
--       virtual_text = true,
--       signs = true,
--       underline = true,
--       update_in_insert = false,
--     })
-- 
--     -- request diagnostics again from active clients so they re-appear
--     for _, client in pairs(vim.lsp.buf_get_clients(0)) do
--       -- ask server to republish diagnostics for all buffers it knows about
--       -- not all servers respond to workspace/diagnostic request; safe to try
--       pcall(function()
--         if client and client.request then
--           client.request("workspace/diagnostic/refresh", nil, function() end, 0)
--         end
--       end)
--     end
-- 
--     -- show diagnostics that are present in the diagnostic store
--     vim.diagnostic.show()
--     print("Diagnostics: ON")
--   else
--     -- turn off visual components so future renderings are suppressed
--     vim.diagnostic.config({
--       virtual_text = false,
--       signs = false,
--       underline = false,
--       update_in_insert = false,
--     })
-- 
--     -- clear existing diagnostics from buffers
--     -- If you want only current buffer, replace 0 with buf number
--     vim.diagnostic.hide()        -- hides diagnostics rendered
--     vim.diagnostic.clear()       -- clears diagnostic entries from all buffers
-- 
--     -- close floating windows (diagnostic floats)
--     close_all_floats()
-- 
--     print("Diagnostics: OFF")
--   end
-- end
-- 
-- -- keymap: <leader>de toggles
-- -- vim.keymap.set("n", "<leader>td", M.toggle, { desc = "Toggle diagnostics (full disable/enable)" })
-- 
-- return M

local M = {}

M.diagnostics_active = true

function M.toggle_diagnostics()
    M.diagnostics_active = not M.diagnostics_active

    if M.diagnostics_active then
        vim.diagnostic.enable(0)
        print("Diagnostics: ON")
    else
        -- Disable diagnostics (buffer 0)
        vim.diagnostic.disable(0)

        -- Clear ALL diagnostic signs, virtual text, underlines, etc.
        for _, ns in ipairs(vim.diagnostic.get_namespaces()) do
            vim.diagnostic.reset(ns)
        end

        -- Force-hide floating diagnostics
        vim.diagnostic.hide(nil, 0)

        print("Diagnostics: OFF")
    end
end

return M
