return {
  {
    "dmmulroy/tsc.nvim",
    cmd = "TSC",
    keys = {
      { "<leader>ts", "<cmd>TSC<cr>", desc = "TypeScript Check", }
    },
    opts = {
      build = true,
    },
  }
}
