return {
  "akinsho/toggleterm.nvim",
  keys = {
    { "<c-t>" },
  },
  version = "*",
  opts = {
    open_mapping = [[<c-t>]],
    insert_mappings = true,
    size = function()
      -- this is supposed to calculate half of the screen, but..
      return vim.fn.winheight(0)
    end,
  },
}
