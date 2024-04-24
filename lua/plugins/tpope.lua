vim.cmd("autocmd! BufReadPost fugitive://* set bufhidden=delete")

vim.cmd("autocmd! FileType git lua _handle_git()")
function _G._handle_git()
  vim.cmd("setlocal foldmethod=syntax")
  vim.cmd("setlocal foldlevel=0")
  vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
end

vim.cmd("autocmd! FileType fugitive lua _handle_fugitive()")
function _G._handle_fugitive()
  vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = true })
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
  {
    "tpope/vim-dadbod",
  },

  {
    "tommcdo/vim-fubitive",
    dependencies = { "tpope/vim-fugitive" },
  },
}
