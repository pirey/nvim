-- patch_hl adds highlight definition without replacing original highlight
-- useful when we need to override highlight and retain existing definition
-- @param hlg string Highlight group
Util = {}
function Util.patch_hl(hlg, patch)
  local hl = vim.api.nvim_get_hl(0, {
    name = hlg,
  })
  vim.api.nvim_set_hl(0, hlg, vim.tbl_deep_extend("keep", patch, hl))
end

function Util.patch_group_pattern(hlg_pattern, patch)
  for _, hlg in pairs(vim.fn.getcompletion(hlg_pattern, "highlight")) do
    Util.patch_hl(hlg, patch)
  end
end

return Util
