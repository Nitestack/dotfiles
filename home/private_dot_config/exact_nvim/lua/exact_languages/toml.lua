-- ╭─────────────────────────────────────────────────────────╮
-- │ TOML                                                    │
-- ╰─────────────────────────────────────────────────────────╯

return utils.plugin.get_language_spec({
  plugins = {
    { import = "lazyvim.plugins.extras.lang.toml" },
  },
})
