-- ╭─────────────────────────────────────────────────────────╮
-- │ Hyprlang                                                │
-- ╰─────────────────────────────────────────────────────────╯

return utils.plugin.get_language_spec({
  mason = "hyprls",
  treesitter = "hyprlang",
  lsp = {
    hyprls = {},
  },
})
