return utils.plugin.with_extensions({
  {
    "folke/snacks.nvim",
    keys = core.lazy_map({
      n = {
        [{ "<leader>e", "<leader>E" }] = { false },
      },
    }),
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      -- Dashboard
      dashboard = {
        preset = {
          header = core.config.ui.logo,
        },
      },
      -- Indent
      indent = {
        indent = {
          char = core.icons.ui.LineLeft,
        },
        scope = {
          char = core.icons.ui.LineLeft,
        },
      },
      -- Picker
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
      -- Scroll
      scroll = {
        animate = {
          duration = { step = 5, total = 200 },
          fps = not core.config.performance_mode and 144,
        },
      },
      -- Terminal
      terminal = {
        win = {
          style = "float",
        },
      },
      -- Window
      win = {
        border = "rounded",
      },
    },
  },
}, {
  catppuccin = {
    snacks = true,
  },
})
