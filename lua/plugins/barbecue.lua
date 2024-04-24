return {
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
      include_buftypes = { "", "nowrite" },
      exclude_filetypes = { "netrw", "toggleterm", "terminal" },
      -- configurations go here
    },
  },
}
