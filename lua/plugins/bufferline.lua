return {
  {
    "akinsho/bufferline.nvim",
    init = function()
      vim.keymap.set(
        "n",
        "<leader>bo",
        "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
        { desc = "Close other buffers" }
      )
    end,
  },
}
