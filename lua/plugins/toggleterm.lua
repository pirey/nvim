return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<leader>t]],
    insert_mappings = false,
    size = function()
      -- this is supposed to calculate half of the screen, but..
      return vim.fn.winheight(0)
    end,
  },
}
