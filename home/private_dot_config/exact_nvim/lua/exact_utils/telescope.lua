--------------------------------------------------------------------------------
--  TELESCOPE UTILS
--------------------------------------------------------------------------------
---@class utils.telescope.opts
---@field show_untracked? boolean

---@class utils.telescope
---@overload fun(builtin:string, opts?:utils.telescope.opts): fun()
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.builtin(...)
  end,
})

-- this will return a function that calls telescope.
-- for `files`, git_files or find_files will be chosen depending on .git
---@param builtin string
---@param opts? utils.telescope.opts
function M.builtin(builtin, opts)
  local params = { builtin = builtin, opts = opts or {} }
  return function()
    builtin = params.builtin
    opts = params.opts
    if builtin == "files" then
      if
        vim.uv.fs_stat(vim.uv.cwd() .. "/.git")
        and not vim.uv.fs_stat(vim.uv.cwd() .. "/.ignore")
        and not vim.uv.fs_stat(vim.uv.cwd() .. "/.rgignore")
      then
        if opts.show_untracked == nil then
          opts.show_untracked = true
        end
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end

return M