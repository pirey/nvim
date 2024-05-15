return {
  "cocopon/iceberg.vim",
  init = function()
    local custom_highlight = vim.api.nvim_create_augroup("CustomIceberg", {})
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "iceberg",
      callback = function()
        -- #272c42
        local bg = "#161821"
        vim.api.nvim_set_hl(0, "CursorLineNr", { bg = bg })
        vim.api.nvim_set_hl(0, "LineNr", { bg = bg })
        vim.api.nvim_set_hl(0, "Folded", { bg = bg })
        vim.api.nvim_set_hl(0, "NonText", { fg = bg })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = bg, bg = bg })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#272c42" })
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#272c42" })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#272c42" })
        vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#45493e", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = "#384851", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#53343b", fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffText", { bg = "#5b7881", fg = "NONE" })
      end,
      group = custom_highlight,
    })
  end,
}
-- return {
--   "oahlen/iceberg.nvim",
--   lazy = true,
-- }
