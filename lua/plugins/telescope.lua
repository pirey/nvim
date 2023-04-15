return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").load_extension("notify")
    end,
    keys = {
      { "<leader>gs", false },
      { "<leader>gc", false },
    },
  },
}
