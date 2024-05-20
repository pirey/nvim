-- patch_hl adds highlight definition without replacing original highlight
-- useful when we need to override highlight and retain existing definition
-- @param hlg string Highlight group
local function patch_hl(hlg, patch)
  local hl = vim.api.nvim_get_hl(0, {
    name = hlg,
  })
  vim.api.nvim_set_hl(0, hlg, vim.tbl_deep_extend("keep", patch, hl))
end

local function patch_group_pattern(hlg_pattern, patch)
  for _, hlg in pairs(vim.fn.getcompletion(hlg_pattern, "highlight")) do
    patch_hl(hlg, patch)
  end
end

return {
  "cocopon/iceberg.vim",
  init = function()
    local custom_highlight = vim.api.nvim_create_augroup("CustomIceberg", { clear = true })
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "iceberg",
      callback = function()
        local bg = "#161821"
        local fg_dark = "#3e445e" -- from StatusLineNC
        local bg_dark = "#0f1117" -- from StatusLineNC
        local fg = "#c6c8d1"
        local visual = "#272c42"
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { bg = bg, fg = "#444b71" })
        -- vim.api.nvim_set_hl(0, "Folded", { bg = bg })
        vim.api.nvim_set_hl(0, "NonText", { fg = bg })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg, bg = bg })
        vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#45493e", fg = "NONE" })
        -- vim.api.nvim_set_hl(0, "DiffChange", { bg = "#384851", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = visual, fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#53343b", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffText", { bg = "#384851", fg = "NONE" })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = fg_dark, bold = true })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#3e445e" })
        -- vim.api.nvim_set_hl(0, "StatusLine", { fg = fg, bg = bg, bold = true })

        -- Notify
        vim.api.nvim_set_hl(0, "NotifyBackground", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = fg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = fg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = fg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = fg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = fg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = fg })
        vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = fg, bg = bg })

        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = fg_dark, bg = bg })

        patch_group_pattern("GitGutter", { bg = bg })
        patch_group_pattern("Diagnostic", { bg = bg })

        -- disable lsp semantic token highlight
        -- for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
        --   vim.api.nvim_set_hl(0, group, {})
        -- end
      end,
      group = custom_highlight,
    })
  end,
}
