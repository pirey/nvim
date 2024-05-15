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
        local visual = "#272c42"
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg })
        vim.api.nvim_set_hl(0, "LineNr", { bg = bg })
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
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3e445e" })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#3e445e" })
      end,
      group = custom_highlight,
    })
  end,
}
