return utils.plugin.with_extensions({
  { import = "lazyvim.plugins.extras.ai.copilot" },
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = { ["*"] = true },
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
}, {
  which_key = {
    { "<leader>a", group = "AI" },
  },
})
