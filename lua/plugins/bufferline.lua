return {
  {
    "akinsho/bufferline.nvim",
    init = function()
      vim.keymap.set("n", "<leader>bo", function()
        vim.cmd("only")
        vim.cmd("BufferLineCloseLeft")
        vim.cmd("BufferLineCloseRight")
      end, {
        desc = "Close other buffers and windows",
      })
    end,
    opts = {
      options = {
        offsets = {},
      },
    },
  },
}
