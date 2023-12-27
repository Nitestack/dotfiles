---@type LazyConfig
return {
  spec = {
    {
      "LazyVim/LazyVim",
      import = "lazyvim.plugins",
      opts = core.config.lazyvim,
    },
    { import = "plugins.languages" },
    { import = "plugins.lsp" },
    { import = "plugins" },
    utils.general.disabled_plugins(core.config.disabled_plugins),
  },
  defaults = {
    lazy = true,
    version = false,
  },
  install = { colorscheme = { "catppuccin", "habamax" } },
  ui = {
    size = { width = core.config.ui.width, height = core.config.ui.height },
    border = core.config.ui.transparent.floats and "rounded" or "none",
    icons = {
      loaded = core.icons.ui.PackageInstalled,
      not_loaded = core.icons.ui.PackageUninstalled,
    },
  },
  checker = { enabled = true },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
