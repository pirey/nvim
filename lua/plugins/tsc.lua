return {
  {
    "dmmulroy/tsc.nvim",
    enabled = false,
    cmd = "TSC",
    keys = {
      { "<leader>ts", "<cmd>TSC<cr>", desc = "TypeScript Check", }
    },
    opts = {
      build = true,
    },
  }
}
