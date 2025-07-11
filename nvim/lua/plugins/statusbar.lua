return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        component_separators = { left = "|", right = "|" },
        section_separators   = { left = "|", right = "|" },
      },
      sections = {
        lualine_c = { { "filename", path = 3 }, "filesize" },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
      },
    })
  end,
}
