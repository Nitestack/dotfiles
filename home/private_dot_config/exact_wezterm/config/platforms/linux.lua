-- ╭─────────────────────────────────────────────────────────╮
-- │ LINUX CONFIG                                            │
-- ╰─────────────────────────────────────────────────────────╯

local M = {}

---@module "wezterm"
---@param config Config
function M.setup(config)
  -- ── Settings ────────────────────────────────────────────────────────
  config.integrated_title_button_style = "Gnome"
  config.bypass_mouse_reporting_modifiers = "CTRL"

  -- On Hyprland
  config.enable_tab_bar = false
  -- NOTE: Temporary solution to make WezTerm work
  config.enable_wayland = false
end

return M
