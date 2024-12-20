return utils.plugin.with_extensions({
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = core.lazy_map({
      n = {
        [{ "<leader>e", "<leader>E" }] = { false },
      },
    }),
    opts = function(_, opts)
      -- Show hidden files
      opts.filesystem = opts.filesystem or {}
      opts.filesystem.filtered_items = opts.filesystem.filtered_items or {}
      opts.filesystem.filtered_items.show_hidden_count = false
      opts.filesystem.filtered_items.hide_dotfiles = false
      opts.filesystem.filtered_items.hide_gitignored = false
      opts.filesystem.filtered_items.hide_hidden = false
    end,
  },
}, {
  lualine = "neo-tree",
  catppuccin = {
    neotree = true,
  },
})
