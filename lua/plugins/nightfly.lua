if true then
  return {}
end
return {
  "pirey/vim-nightfly-colors",
  name = "nightfly",
  -- lazy = false,
  -- priority = 1000,
  config = function()
    -- customize highlighting
    local colors = require("nightfly").palette
    local custom_highlight = vim.api.nvim_create_augroup("CustomNightfly", {})
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "nightfly",
      callback = function()
        vim.api.nvim_set_hl(0, "NonText", { fg = colors.bg, bg = "NONE" })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = colors.fg, bg = colors.deep_blue })
        vim.api.nvim_set_hl(0, "StatusLineNC", { fg = colors.fg, bg = colors.black_blue })
      end,
      group = custom_highlight,
    })

    -- global options
    vim.g.nightflyWinSeparator = 2
    vim.g.nightflyUnderlineMatchParen = false

    -- activate colorscheme
    -- vim.cmd.colorscheme("nightfly")
  end,
}
