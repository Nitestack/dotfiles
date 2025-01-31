return utils.plugin.with_extensions({
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
      "MasonToolsClean",
    },
    opts = function(_, opts)
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, core.config.plugins.mason)
    end,
    -- opts_extend = { "ensure_installed" },
    -- opts = {
    --   ensure_installed = core.config.plugins.mason,
    -- },
    config = function(_, opts)
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed or {})
      require("mason-tool-installer").setup(opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = "WhoIsSethDaniel/mason-tool-installer.nvim",
    ---@module "mason"
    ---@type MasonSettings
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
}, {
  lualine = "mason",
  catppuccin = {
    mason = true,
  },
})
