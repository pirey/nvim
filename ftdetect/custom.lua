local augroup = vim.api.nvim_create_augroup('CustomFtdetect', { clear = true })

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = augroup,
  pattern = "*.blade.php",
  callback = function()
    vim.opt.filetype = "html"
  end
})
