vim.cmd("autocmd! BufReadPost fugitive://* set bufhidden=delete")

vim.cmd("autocmd! FileType git lua _handle_git()")
function _G._handle_git()
  vim.cmd("setlocal foldmethod=syntax")
  vim.cmd("setlocal foldlevel=0")
end

return {
  {
    "tpope/vim-fugitive",
  },
  {
    "tpope/vim-surround",
  },
  {
    "tpope/vim-abolish",
  },
}
