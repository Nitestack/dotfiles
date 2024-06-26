return utils.plugin.with_extensions({
  { import = "lazyvim.plugins.extras.editor.telescope" },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = core.lazy_map({
      n = {
        [{
          "<leader>,",
          "<leader><Space>",
          "<leader>fb",
          "<leader>fc",
          "<leader>fr",
          "<leader>fR",
          "<leader>gc",
          "<leader>gs",

          "<leader>sd",
          "<leader>sD",
          "<leader>sH",
          "<leader>sj",
          "<leader>sk",
          "<leader>sl",
          "<leader>sm",
          "<leader>so",
          "<leader>sR",
          "<leader>sq",
          "<leader>uC",
          "<leader>ss",
          "<leader>sS",
        }] = { false },
        ["<leader>fp"] = {
          function()
            require("telescope.builtin").find_files({
              cwd = require("lazy.core.config").options.root,
            })
          end,
          desc = "Find Plugin File",
        },
      },
    }),
    opts = function(_, opts)
      local actions = require("telescope.actions")

      opts.defaults = opts.defaults or {}
      opts.defaults.prompt_prefix = core.icons.ui.Telescope .. " "
      opts.defaults.selection_caret = core.icons.ui.ChevronShortRight .. " "
      opts.defaults.sorting_strategy = "ascending"
      opts.defaults.layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.5,
        },
        vertical = {
          mirror = false,
        },
        width = core.config.ui.width,
        height = core.config.ui.height,
        preview_cutoff = 120,
      }
      opts.defaults.path_display = { "truncate", "filename_first" }
      opts.defaults.file_ignore_patterns = { "node_modules", ".git", ".next", "dist", "build", "target" }
      opts.defaults.mappings = {
        i = {
          ["<ESC>"] = actions.close,
        },
      }
      opts.defaults.vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      }

      opts.pickers = opts.pickers or {}
      opts.pickers.find_files = {
        theme = "dropdown",
        previewer = false,
      }
      opts.pickers.git_files = {
        theme = "dropdown",
        previewer = false,
      }
    end,
  },
}, {
  telescope = {
    extensions = "fzf",
  },
  catppuccin = {
    telescope = {
      enabled = true,
      style = "nvchad",
    },
  },
})
