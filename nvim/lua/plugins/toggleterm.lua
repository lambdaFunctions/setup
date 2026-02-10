local ok, toggleterm = pcall(require, "toggleterm")
if not ok then return end

toggleterm.setup({ 
    direction = "float", autochdir = true
    -- size = 15, direction = "horizontal", autochdir = true
})

