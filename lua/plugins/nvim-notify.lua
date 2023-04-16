return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("telescope").load_extension("notify")
    end,
  },
}
