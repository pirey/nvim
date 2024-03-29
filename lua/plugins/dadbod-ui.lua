return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.cmd([[
      augroup DBUIAutocommands
        autocmd!
        autocmd FileType dbui nnoremap <buffer> l <Plug>(DBUI_SelectLine)
        autocmd FileType dbui nnoremap <buffer> h <Plug>(DBUI_SelectLine)
      augroup END
    ]])
  end,
}
