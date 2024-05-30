return {
  "oxfist/night-owl.nvim",
  lazy = true, -- make sure we load this during startup if it is your main colorscheme
  -- priority = 1000, -- make sure to load this before all the other start plugins
  -- config = function()
  --   -- load the colorscheme here
  --   require("night-owl").setup()
  --   vim.cmd.colorscheme("night-owl")
  -- end,
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "night-owl",
      callback = function()
        local colors = require("night-owl.palette")
        local util = require("util")

        vim.api.nvim_set_hl(0, "DiffAdd", { bg = colors.blue5, fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = colors.blue2, fg = "NONE" })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = colors.folded_bg, fg = "NONE" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.dark })
        util.patch_hl("DiffText", { fg = "NONE" })
      end,
    })
  end,
}
