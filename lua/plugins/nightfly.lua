return {
  "bluz71/vim-nightfly-colors",
  name = "nightfly",
  lazy = false,
  priority = 1000,
  config = function()
    local colors = require("nightfly").palette
    local custom_highlight = vim.api.nvim_create_augroup("CustomNightfly", {})
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "nightfly",
      callback = function()
        vim.api.nvim_set_hl(0, "NonText", { fg = colors.bg, bg = "NONE" })
      end,
      group = custom_highlight,
    })
    vim.g.nightflyWinSeparator = 2
    vim.g.nightflyUnderlineMatchParen = false
    -- vim.cmd.colorscheme("nightfly")
  end,
}
