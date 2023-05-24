local M = {}

if vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 then
  table.insert(M, {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        always_show_bufferline = true,
      },
    },
  })
end

return M
