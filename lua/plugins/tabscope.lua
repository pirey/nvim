return {
  { "backdround/tabscope.nvim", config = true, enabled = false },
  {
    "tiagovla/scope.nvim",
    config = function()
      require("telescope").load_extension("scope")
      require("scope").setup({})
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>ba",
        function()
          vim.cmd("Telescope scope buffers")
        end,
        desc = "Select Buffer (All Tabs)",
      },
    },
  },
}
