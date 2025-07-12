return {
  {
    "lifepillar/vim-solarized8",
    enabled = false,
    init = function()
      -- vim.opt.background = "light"
      -- vim.opt.cursorline = true
      -- vim.opt.number = true
      -- vim.cmd.colorscheme("solarized8")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = true,
    enabled = false,
    config = function()
      require("github-theme").setup({
        groups = {
          all = {
            StatusLine = { link = "TabLine" },
            StatusLineNC = { link = "TabLineFill" },
          },
        },
      })
      -- vim.opt.background = "light"
      -- vim.opt.cursorline = true
      -- vim.opt.cursorlineopt = "number"
      -- vim.opt.number = true
      -- vim.cmd.colorscheme("github_light")
    end,
  },
}
