vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = false
opt.wildoptions = "pum"
opt.path:append("**")
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

