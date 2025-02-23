-- ╭─────────────────────────────────────────────────────────╮
-- │ Mapping Utils                                           │
-- ╰─────────────────────────────────────────────────────────╯

---@class utils.mappings
local M = {}

---@alias utils.mappings.mappings_spec.mappings table<string|string[], utils.mappings.mapping|string>
---@alias utils.mappings.lazy_mappings_spec.mappings table<string|string[], utils.mappings.lazy_mapping|string>

---@class utils.mappings.mappings_spec
---@field n? utils.mappings.mappings_spec.mappings Normal Mode keymaps
---@field x? utils.mappings.mappings_spec.mappings Visual Mode keymaps
---@field s? utils.mappings.mappings_spec.mappings Select Mode keymaps
---@field v? utils.mappings.mappings_spec.mappings Visual + Select Mode keymaps
---@field o? utils.mappings.mappings_spec.mappings Operator-Pending Mode keymaps
---@field i? utils.mappings.mappings_spec.mappings Insert Mode keymaps
---@field c? utils.mappings.mappings_spec.mappings Command-Line Mode keymaps
---@field l? utils.mappings.mappings_spec.mappings Insert + Command-Line + Lang-Arg Mode keymaps
---@field t? utils.mappings.mappings_spec.mappings Terminal Mode keymaps
---@field ['"!"']? utils.mappings.mappings_spec.mappings Insert + Command-Line Mode keymaps
---@field ['""']? utils.mappings.mappings_spec.mappings Normal, Visual and Operating-Pending Mode keymaps

---@class utils.mappings.lazy_mappings_spec
---@field n? utils.mappings.lazy_mappings_spec.mappings Normal Mode keymaps
---@field x? utils.mappings.lazy_mappings_spec.mappings Visual Mode keymaps
---@field s? utils.mappings.lazy_mappings_spec.mappings Select Mode keymaps
---@field v? utils.mappings.lazy_mappings_spec.mappings Visual + Select Mode keymaps
---@field o? utils.mappings.lazy_mappings_spec.mappings Operator-Pending Mode keymaps
---@field i? utils.mappings.lazy_mappings_spec.mappings Insert Mode keymaps
---@field c? utils.mappings.lazy_mappings_spec.mappings Command-Line Mode keymaps
---@field l? utils.mappings.lazy_mappings_spec.mappings Insert + Command-Line + Lang-Arg Mode keymaps
---@field t? utils.mappings.lazy_mappings_spec.mappings Terminal Mode keymaps
---@field ['"!"']? utils.mappings.lazy_mappings_spec.mappings Insert + Command-Line Mode keymaps
---@field ['""']? utils.mappings.lazy_mappings_spec.mappings Normal, Visual and Operating-Pending Mode keymaps

---@class utils.mappings.mapping:utils.mappings.mapping_opts
---@field [1] string|fun()

---@class utils.mappings.lazy_mapping:utils.mappings.mapping_opts
---@field [1] string|fun()|false

---@class utils.mappings.mapping_opts:vim.api.keyset.keymap
---@field remap? boolean Make the mapping recursive. Inverse of {noremap}.
---@field buffer? integer|boolean Specify the buffer that the keymap will be effective in. If `0` or `true`, the current buffer will be used
---@field ft? string|string[] Specify the filetype that the keymap will be effective in

---Loads mappings (with `vim.keymap.set`)
---@param mappings utils.mappings.mappings_spec
---@param mapping_opts? utils.mappings.mapping_opts|{ prefix?: string }
function M.map(mappings, mapping_opts)
  local prefix = ""
  if mapping_opts ~= nil and mapping_opts.prefix ~= nil then
    prefix = mapping_opts.prefix
    mapping_opts.prefix = nil
  end

  for mode, mode_mappings in
    pairs(vim.deepcopy(mappings --[[@as table<string|string[], utils.mappings.mappings_spec.mappings>]]))
  do
    for mapping, mapping_info in pairs(mode_mappings) do
      local _mapping_info = vim.deepcopy(mapping_info)
      local rhs = _mapping_info[1]
      local ft = _mapping_info.ft
      mapping_info[1] = nil
      mapping_info.ft = nil

      local function create_mapping(buf)
        local opts = vim.tbl_deep_extend("force", mapping_opts or {}, buf and { buffer = buf } or {}, mapping_info) --[[@as vim.keymap.set.Opts]]

        if type(mapping) == "string" then
          vim.keymap.set(mode, prefix .. mapping, rhs, opts)
        else
          for _, keymap in ipairs(mapping) do
            vim.keymap.set(mode, prefix .. keymap, rhs, opts)
          end
        end
      end

      if ft ~= nil then
        vim.api.nvim_create_autocmd("FileType", {
          pattern = ft,
          callback = function(event)
            vim.schedule(function()
              create_mapping(event.buf)
            end)
          end,
        })
      else
        create_mapping()
      end
    end
  end
end

---@module "lazy"

---Loads mappings for `lazy.nvim` plugin spec
---@param mappings utils.mappings.lazy_mappings_spec
---@param mapping_opts? utils.mappings.mapping_opts|{ prefix?: string }
---@return LazyKeysSpec[]
function M.lazy_map(mappings, mapping_opts)
  local lazy_mappings = {}

  local prefix = ""
  if mapping_opts ~= nil and mapping_opts.prefix ~= nil then
    prefix = mapping_opts.prefix
    mapping_opts.prefix = nil
  end

  for mode, mode_mappings in
    pairs(mappings --[[@as table<string|string[], utils.mappings.lazy_mappings_spec.mappings|string>]])
  do
    for mapping, mapping_info in pairs(mode_mappings) do
      -- Native which-key group keymaps
      if type(mapping_info) == "string" then
        if type(mapping) == "string" then
          table.insert(lazy_mappings, { mode = mode, prefix .. mapping, "", desc = mapping_info })
        else
          for _, keymap in ipairs(mapping) do
            table.insert(lazy_mappings, { mode = mode, prefix .. keymap, "", desc = mapping_info })
          end
        end
      else
        local rhs = vim.deepcopy(mapping_info)[1]
        mapping_info[1] = nil
        local opts = vim.tbl_deep_extend("force", mapping_opts or {}, mapping_info)
        opts.mode = mode

        if type(mapping) == "string" then
          table.insert(lazy_mappings, vim.tbl_extend("force", opts, { prefix .. mapping, rhs }))
        else
          for _, keymap in ipairs(mapping) do
            table.insert(lazy_mappings, vim.tbl_extend("force", opts, { prefix .. keymap, rhs }))
          end
        end
      end
    end
  end

  return lazy_mappings
end

return M
