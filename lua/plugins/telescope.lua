return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gs", false },
      { "<leader>gc", false },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
}
