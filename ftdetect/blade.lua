vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.blade.php",
  callback = function()
    vim.opt.filetype = "html"
  end
})
