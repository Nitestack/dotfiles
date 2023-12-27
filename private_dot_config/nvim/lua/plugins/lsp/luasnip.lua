return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    {
      "Exafunction/codeium.vim",
      keys = core.lazy_map({
        i = {
          ["<C-a>"] = {
            function()
              return vim.fn["codeium#Accept"]()
            end,
            "Codeium: Accept suggestion",
            opts = {
              silent = true,
              expr = true,
            },
          },
        },
      }),
    },
  },
  keys = core.lazy_map({
    i = {
      ["<Tab>"] = {
        function()
          if require("luasnip").expand_or_jumpable() then
            return "<Plug>luasnip-expand-or-jump"
          else
            return vim.fn["codeium#Accept"]()
          end
        end,
        "Super-tab: expand/jump or accept Codeium suggestion",
        opts = {
          silent = true,
          expr = true,
        },
      },
    },
    [{ "i", "s" }] = {
      ["<C-l>"] = {
        function()
          local ls = require("luasnip")
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        opts = {
          silent = true,
        },
      },
    },
  }),
  opts = function(_, opts)
    local ls = require("luasnip")
    local extras = require("luasnip.extras")

    opts.enable_autosnippets = true
    opts.update_events = { "TextChanged", "TextChangedI" }
    opts.snip_env = vim.tbl_deep_extend("force", opts.snip_env or {}, {
      s = ls.snippet,
      ms = ls.multi_snippet,
      sn = ls.snippet_node,
      isn = ls.indent_snippet_node,
      t = ls.text_node,
      i = ls.insert_node,
      f = ls.function_node,
      c = ls.choice_node,
      d = ls.dynamic_node,
      r = ls.restore_node,
      l = extras.lambda,
      rep = extras.rep,
      p = extras.partial,
      m = extras.match,
      n = extras.nonempty,
      dl = extras.dynamic_lambda,
      fmt = require("luasnip.extras.fmt").fmt,
      fmta = require("luasnip.extras.fmt").fmta,
      conds = require("luasnip.extras.expand_conditions"),
      postfix = require("luasnip.extras.postfix").postfix,
    })
  end,
  config = function(_, opts)
    local ls = require("luasnip")
    ls.setup(opts)

    core.user_cmds({
      {
        "LuaSnipEdit",
        function()
          require("luasnip.loaders").edit_snippet_files()
        end,
      },
    })

    -- Load snippets from <nvim_config_dir>/luasnippets
    require("luasnip.loaders.from_lua").lazy_load()
  end,
}
