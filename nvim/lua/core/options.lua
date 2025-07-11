vim.cmd("let g:netrw_liststyle = 3")

-- Homebrew binaries (tree-sitter, clangd, etc.) may not be in nvim's PATH.
-- Covers Apple Silicon (/opt/homebrew) and Intel (/usr/local) layouts,
-- plus the versioned llvm prefix needed for clang when compiling TS parsers.
for _, p in ipairs({
  "/opt/homebrew/bin",
  "/opt/homebrew/opt/llvm/bin",
  "/usr/local/bin",
  "/usr/local/opt/llvm/bin",
}) do
  if vim.fn.isdirectory(p) == 1 then
    vim.env.PATH = p .. ":" .. vim.env.PATH
  end
end

local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.cursorlineopt = "number"
opt.wildoptions = "pum"
opt.path:append("**")
opt.wrap = false
opt.swapfile = false
opt.signcolumn = "yes"      -- Avoid the LSP Warnings/Errors from shifting the number column
opt.fillchars:append({ eob = " " })  -- Hide the "~" tildes past end-of-buffer, in every window

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

