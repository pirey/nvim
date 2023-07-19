local colors = require("tokyonight.colors").moon()
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
        always_show_bufferline = true,
      },
      -- highlights = {
      --   fill = {
      --     bg = colors.bg,
      --   },
      --   background = {
      --     bg = colors.bg,
      --   },
      --   buffer_selected = {
      --     bg = colors.bg_dark,
      --   },
      --   buffer_visible = {
      --     bg = colors.bg,
      --   },
      --   close_button = {
      --     bg = colors.bg,
      --   },
      --   close_button_visible = {
      --     bg = colors.bg,
      --   },
      --   close_button_selected = {
      --     bg = colors.bg_dark,
      --   },
      --   separator = {
      --     bg = colors.bg,
      --   },
      -- },
    },
  },
}
