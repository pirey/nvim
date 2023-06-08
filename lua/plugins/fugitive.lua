vim.cmd("autocmd! BufReadPost fugitive://* set bufhidden=delete")

-- vim.cmd("autocmd! FileType git setlocal foldmethod=syntax")

vim.cmd("autocmd! FileType git lua _handle_git()")
function _G._handle_git()
  vim.cmd("setlocal foldmethod=syntax")
  vim.cmd("setlocal foldlevel=0")
  -- vim.o.foldmethod = "syntax"
  -- vim.o.foldlevel = 0
  vim.keymap.set("n", "zz", function ()
    -- vim.o.foldmethod = "syntax"
    -- vim.o.foldlevel = 0
    vim.cmd("setlocal foldmethod=syntax")
    vim.cmd("setlocal foldlevel=0")
  end)
end

return {
  {
    "tpope/vim-fugitive",
  },
}
