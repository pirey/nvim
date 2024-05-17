local function patch_hl(hlg, patch)
  local hl = vim.api.nvim_get_hl(0, {
    name = hlg,
  })
  vim.api.nvim_set_hl(0, hlg, vim.tbl_deep_extend("keep", patch, hl))
end

return {
  "cocopon/iceberg.vim",
  init = function()
    local custom_highlight = vim.api.nvim_create_augroup("CustomIceberg", {})
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "iceberg",
      callback = function()
        local bg = "#161821"
        local bg_dark = "#3e445e" -- from StatuslineNC
        local fg = "#c6c8d1"
        local visual = "#272c42"
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg, bold = true })
        vim.api.nvim_set_hl(0, "LineNr", { bg = bg, fg = "#444b71" })
        vim.api.nvim_set_hl(0, "Folded", { bg = bg })
        vim.api.nvim_set_hl(0, "NonText", { fg = bg })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg, bg = bg })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = visual })
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = visual })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = visual })
        vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#45493e", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = "#384851", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#53343b", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffText", { bg = "#5b7881", fg = "NONE" })
        patch_hl("GitGutterAdd", { bg = bg })
        patch_hl("GitGutterChange", { bg = bg })
        patch_hl("GitGutterDelete", { bg = bg })
        patch_hl("DiagnosticSignInfo", { bg = bg })
        patch_hl("DiagnosticSignError", { bg = bg })
        patch_hl("DiagnosticSignOk", { bg = bg })
        patch_hl("DiagnosticSignWarn", { bg = bg })
        patch_hl("DiagnosticSignHint", { bg = bg })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = bg_dark })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#3e445e" })
        vim.api.nvim_set_hl(0, "IncSearch", { fg = "NONE", bg = visual })

        -- Notify
        vim.api.nvim_set_hl(0, "NotifyBackground", { fg = fg, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = bg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = bg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = bg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = bg_dark, bg = bg })
        vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = bg_dark, bg = bg })
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
      end,
      group = custom_highlight,
    })
  end,
}
