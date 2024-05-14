return {
  "cocopon/iceberg.vim",
  init = function()
    local custom_highlight = vim.api.nvim_create_augroup("CustomIceberg", {})
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "iceberg",
      callback = function()
        -- #272c42
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#161821" })
        vim.api.nvim_set_hl(0, "LineNr", { bg = "#161821" })
        vim.api.nvim_set_hl(0, "NonText", { fg = "#161821" })
      end,
      group = custom_highlight,
    })
  end,
}
-- return {
--   "oahlen/iceberg.nvim",
--   lazy = true,
-- }
