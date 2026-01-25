local ok, lualine = pcall(require, "lualine")
if not ok then return end

lualine.setup({
    options = {
        icons_enabled = false,
        -- theme = 'seoul256',
        component_separators = { left = '|', right = '|' },
        section_separators = { left = '|', right = '|' },
    },
    sections = {
        lualine_c = { { 'filename', path = 3 }, 'filesize' },
        lualine_x = { 'filezie', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
    }
})

