return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  opts = {
    preview = { winblend = 0, border = "single", show_title = false }
  },
  init = function()
    vim.cmd([[
    hi link BqfPreviewBorder Normal
    hi link BqfPreviewRange Visual
    ]])
  end
}
