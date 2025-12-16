vim.g.mapleader = " "
local keymap = vim.keymap

keymap.set("n", "<leader>e", "<cmd>Explore<CR>", { desc = "Open Explorer" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
keymap.set("n", "<leader>nh", "<cmd>noh<CR>", { desc = "Clear highlight" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })

-- splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equal split" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<Tab>", "<cmd>tabn<CR>", { desc = "Next tab" })
keymap.set("n", "<S-Tab>", "<cmd>tabp<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Buffer to tab" })

-- INSERT MORE
-- Auto-insert {} and place cursor inside
vim.keymap.set("i", "{", function()
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))

    -- Insert {} at cursor
    vim.api.nvim_put({"{}"}, "c", true, true)

    -- Move cursor one position left (inside the braces)
    vim.api.nvim_win_set_cursor(0, {row, col + 1})
end, { noremap = true })

-- file manager
keymap.set("n", "<leader>fy", "<cmd>Yazi<CR>", { desc = "Open Yazi" })

-- Terminal
require("toggleterm").setup{
    -- size = 80;
    -- direction = "vertical",
    direction = "float",
    autochdir = true,
}

keymap.set('n', '<leader>j', '<CMD>lua require("ToggleTerm").toggle()<CR>')
keymap.set('t', '<ESC>', '<C-\\><C-n><CMD>lua require("ToggleTerm").toggle()<CR>')

-- Telescope bindings
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Spectre (Find and Replace)
keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })
keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', { desc = "Search current word" })
keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', { desc = "Search current word" })
keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', { desc = "Search on current file" })

-- LSP KEYMAPS
-- keymap.set("n", "<leader>lsh", "<cmd>LspHover<CR>", { desc = "Show floating hover window" }) 
-- keymap.set("n", "<leader>lsi", "<cmd>LspPeekImplementation<CR>", { desc = "Show implementation in floating window" }) 
-- keymap.set("n", "<F12>", "<cmd>tab split | LspDefinition<CR>", { desc = "Go to definition in current window" }) 
keymap.set("n", "<leader>gt", "<cmd>tab split | LspDefinition<CR>", { desc = "Go to definition in current window" }) 
-- keymap.set("n", "<leader>lsd", "<cmd>LspPeekDefinition<CR>", { desc = "Go to definition in a floating window" }) 
keymap.set("n", "<leader>lsw", "<cmd>LspReferences<CR>", { desc = "Show symbol references in a new window" }) 
keymap.set("n", "<leader>lw", "<cmd>LspRename<CR>", { desc = "Rename in entire opened file" }) 

-- -- Rust
vim.lsp.config.rust_analyzer = {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = {"Cargo.toml", ".git"},
    single_file_support = true,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = false;
            }
        }
    },
    before_init = function(init_params, config)
        -- See https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26
        if config.settings and config.settings['rust-analyzer'] then
            init_params.initializationOptions = config.settings['rust-analyzer']
        end
    end,
}

vim.lsp.enable("rust_analyzer")

-- -- Diagnostics
local options = require("core.options")

print("toggle:", vim.inspect(options.toggle_diagnostics))  -- keep this until it prints function

vim.keymap.set("n", "<leader>td", options.toggle_diagnostics, {
    desc = "Toggle LSP diagnostics",
})

