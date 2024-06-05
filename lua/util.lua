local M = {}

--- patch_hl adds highlight definition without replacing original highlight
--- useful when we need to override highlight and retain existing definition
---
--- @param hlg string Highlight group name
--- @param patch table Override highlight
function M.patch_hl(hlg, patch)
  local hl = vim.api.nvim_get_hl(0, {
    name = hlg,
  })
  vim.api.nvim_set_hl(0, hlg, vim.tbl_deep_extend("keep", patch, hl))
end

function M.patch_group_pattern(hlg_pattern, patch)
  for _, hlg in pairs(vim.fn.getcompletion(hlg_pattern, "highlight")) do
    M.patch_hl(hlg, patch)
  end
end

---@param s string
---@param opts? {should_truncate: boolean?, maxlen: integer?}
function M.truncate_string(s, opts)
  opts = vim.tbl_extend("force", {
    should_truncate = true,
    maxlen = 0,
  }, opts or {})
  if opts.should_truncate and opts.maxlen == 0 then
    return ""
  end
  if opts.should_truncate and vim.api.nvim_strwidth(s) >= opts.maxlen then
    local trimmed = string.sub(s, 1, opts.maxlen)
    local pattern = "[-_]$"
    s = string.gsub(trimmed, pattern, "") .. ".."
  end
  return s
end

return M
