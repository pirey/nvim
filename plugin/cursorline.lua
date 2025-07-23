vim.api.nvim_create_autocmd("FileType", {
  pattern = { "orgagenda", "fugitive" },
  group = vim.api.nvim_create_augroup("CustomCursorline", { clear = true }),
  callback = function()
    vim.wo.cursorline = true
  end,
})
