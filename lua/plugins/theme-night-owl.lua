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

        -- Notify
        local notify_fg = colors.fg
        local notify_bg = colors.dark
        local notify_border = colors.dark
        vim.api.nvim_set_hl(0, "NotifyBackground", { fg = notify_fg, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyERRORBorder", { fg = notify_border, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyWARNBorder", { fg = notify_border, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyINFOBorder", { fg = notify_border, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBorder", { fg = notify_border, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyTRACEBorder", { fg = notify_border, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyERRORIcon", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyWARNIcon", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyINFOIcon", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGIcon", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyTRACEIcon", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyERRORTitle", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyWARNTitle", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyINFOTitle", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGTitle", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyTRACETitle", { fg = notify_fg })
        vim.api.nvim_set_hl(0, "NotifyERRORBody", { fg = notify_fg, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyWARNBody", { fg = notify_fg, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyINFOBody", { fg = notify_fg, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyDEBUGBody", { fg = notify_fg, bg = notify_bg })
        vim.api.nvim_set_hl(0, "NotifyTRACEBody", { fg = notify_fg, bg = notify_bg })
      end,
    })
  end,
}
