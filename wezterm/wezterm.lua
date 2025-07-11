local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Macintosh (base16)
-- Abernathy
-- Argonaut (Gogh)
-- astromouse (terminal.sexy)
config.color_scheme = 'Default (dark) (terminal.sexy)'

config.colors = {
  background = '#0d0d0d',
  foreground = '#FFFFFF',
  -- The background color of the cursor (e.g., a block cursor)
  cursor_bg = '#FFFFFF',
  -- The text color inside the cursor
  cursor_fg = 'black',
  -- The border color of the cursor
  cursor_border = '#52ad70',
}

-- https://wezterm.org/config/lua/config/window_decorations.html
config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'

-- Increase padding around the terminal content
config.window_padding = {
  left = '2cell',
  right = '2cell',
  top = '0.5cell',
  bottom = '0.5cell',
}

wezterm.font_with_fallback({
  "Iosevka NFM",
  "JetBrains Mono",
  "PingFang SC",
})

config.font_size = 13.0

local act = wezterm.action

config.keys = {
  {
    key = 'E',
    mods = 'CTRL|SHIFT',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      initial_value = '',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    if tab.is_active then
      return {
        { Background = { Color = 'black' } },
        { Text = ' ' .. title .. ' ' },
      }
    end
  end
)

return config

