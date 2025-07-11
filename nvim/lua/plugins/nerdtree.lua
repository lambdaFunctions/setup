return {
  "preservim/nerdtree",
  init = function()
    vim.g.NERDTreeShowHidden = 1
    vim.g.NERDTreeIgnore = { "\\.pyc$", "\\~$", "\\.git$[[dir]]", "\\.DS_Store$" }
    vim.g.NERDTreeMinimalUI = 1
  end,
  cmd = { "NERDTreeToggle", "NERDTree", "NERDTreeClose" },
}
