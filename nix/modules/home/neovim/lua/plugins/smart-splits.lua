---@type LazyPluginSpec
return {
  "mrjones2014/smart-splits.nvim",
  cmd = {
    "SmartResizeLeft",
    "SmartResizeRight",
    "SmartResizeUp",
    "SmartResizeDown",

    "SmartCursorMoveLeft",
    "SmartCursorMoveRight",
    "SmartCursorMoveUp",
    "SmartCursorMoveDown",

    "SmartSwapLeft",
    "SmartSwapRight",
    "SmartSwapUp",
    "SmartSwapDown",

    "SmartResizeMode",
    "SmartSplitsLog",
    "SmartSplitsLogLevel",
  },
  keys = core.lazy_map({
    n = {
      ["<C-h>"] = {
        function()
          require("smart-splits").move_cursor_left()
        end,
        desc = "Select left window",
      },
      ["<C-l>"] = {
        function()
          require("smart-splits").move_cursor_right()
        end,
        desc = "Select right window",
      },
      ["<C-k>"] = {
        function()
          require("smart-splits").move_cursor_up()
        end,
        desc = "Select upper window",
      },
      ["<C-j>"] = {
        function()
          require("smart-splits").move_cursor_down()
        end,
        desc = "Select lower window",
      },
      ["<C-Up>"] = {
        function()
          require("smart-splits").resize_up()
        end,
        desc = "Increase window height",
      },
      ["<C-Down>"] = {
        function()
          require("smart-splits").resize_down()
        end,
        desc = "Decrease window height",
      },
      ["<C-Left>"] = {
        function()
          require("smart-splits").resize_left()
        end,
        desc = "Decrease window width",
      },
      ["<C-Right>"] = {
        function()
          require("smart-splits").resize_right()
        end,
        desc = "Increase window width",
      },
    },
  }),
  opts = {},
}
