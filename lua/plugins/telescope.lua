return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>gs", false },
      { "<leader>gc", false },
      { "<leader>gS", "<cmd>Telescope git_status<cr>", desc = "Git status with preview" },
    },
    opts = {
      defaults = {
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        path_display = { "truncate" },
      },
    },
  },
}
