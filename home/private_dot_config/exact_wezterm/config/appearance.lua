---@type Wezterm
local wezterm = require("wezterm")

local M = {}

---@param config Config
function M.setup(config)
  -- Font
  config.font = wezterm.font_with_fallback({
    "MonoLisa",
    {
      family = "MonoLisa",
      weight = "Medium",
    },
    "SF Mono",
    "Symbols Nerd Font",
  })
  config.font_size = 18.0
  config.line_height = 1.2

  -- Colors
  config.color_scheme = "Catppuccin Mocha"
  config.window_background_gradient = {
    orientation = "Vertical",
    colors = { "#1e1e2e", "#313244", "#11111b" },
    interpolation = "Linear",
  }

  -- Rendering
  config.animation_fps = 144
  config.max_fps = 144

  config.underline_thickness = 3
  config.cursor_thickness = 4
  config.underline_position = -6

  -- Cursor
  config.cursor_blink_ease_in = "Constant"
  config.cursor_blink_ease_out = "Constant"
  config.cursor_blink_rate = 700
  config.scrollback_lines = 10000

  -- Window
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  config.window_padding = {
    top = 0,
    bottom = 0,
    left = 0,
    right = 0,
  }
  config.enable_scroll_bar = false

  -- Tab Bar
  config.show_tab_index_in_tab_bar = false
  config.switch_to_last_active_tab_when_closing_tab = true
  config.window_frame = {
    font = wezterm.font_with_fallback({
      {
        family = "Geist",
        weight = "Bold",
      },
      "Symbols Nerd Font",
    }),
  }
end

return M
