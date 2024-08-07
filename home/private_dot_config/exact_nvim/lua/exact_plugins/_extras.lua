-- ╭─────────────────────────────────────────────────────────╮
-- │ EXTRAS                                                  │
-- ╰─────────────────────────────────────────────────────────╯
-- https://www.lazyvim.org/extras

return utils.plugin.with_extensions({
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.editor.illuminate" },
  { import = "lazyvim.plugins.extras.util.dot" },
  { import = "lazyvim.plugins.extras.vscode" },
}, {
  catppuccin = {
    illuminate = {
      enabled = true,
      lsp = true,
    },
  },
})
