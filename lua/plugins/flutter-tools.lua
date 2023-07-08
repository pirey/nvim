return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    -- config = true,
    opts = {
      widget_guides = {
        enabled = true,
      },
      closing_tags = {
        -- highlight = "Folded", -- highlight for the closing tag
        prefix = ">", -- character to use for close tag e.g. > Widget
        enabled = true, -- set to false to disable
      },
    },
  },
}
